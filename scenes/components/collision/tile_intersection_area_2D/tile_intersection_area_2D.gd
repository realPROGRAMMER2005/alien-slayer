extends Area2D
class_name TileIntersectionArea

@export var sample_density: int = 100  # Количество точек для сэмплинга (увеличьте для точности, но не более 1000 для производительности)
@export var enable_tile_detection: bool = true  # Флаг для включения/отключения обнаружения тайлов
@export var tilemap_physics_layer: int = 0:  # Физический слой для TileMapLayer (0-31, соответствует TileSet physics layer)
	set(value):
		if value < 0 or value > 31:
			print("Ошибка: tilemap_physics_layer должен быть в диапазоне 0-31. Установлено значение 0.")
			tilemap_physics_layer = 0
		else:
			tilemap_physics_layer = value

var intersecting_tile_layers: Array[TileMapLayer] = []  # Список пересекающихся TileMapLayer
var previous_tiles: Dictionary = {}  # Предыдущее состояние: TileMapLayer -> Array[Vector2i]

signal tile_entered(layer: TileMapLayer, coord: Vector2i)
signal tile_exited(layer: TileMapLayer, coord: Vector2i)

func _ready() -> void:
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body is TileMapLayer and not intersecting_tile_layers.has(body):
		intersecting_tile_layers.append(body)

func _on_body_exited(body: Node) -> void:
	if body is TileMapLayer:
		intersecting_tile_layers.erase(body)
		# Если слой ушёл, удаляем его из previous_tiles
		if previous_tiles.has(body):
			previous_tiles.erase(body)

func _physics_process(delta: float) -> void:
	if not enable_tile_detection:
		return
	
	var current_tiles = get_intersecting_tile_coords()
	
	# Обработка новых и ушедших слоёв
	for layer in current_tiles.keys():
		if not previous_tiles.has(layer):
			previous_tiles[layer] = []
	
	for layer in previous_tiles.keys().duplicate():
		if not current_tiles.has(layer):
			# Если слой больше не пересекается, эмитируем exited для всех его предыдущих тайлов
			for coord in previous_tiles[layer]:
				tile_exited.emit(layer, coord)
			previous_tiles.erase(layer)
			continue
	
	# Сравнение тайлов для каждого слоя
	for layer in current_tiles.keys():
		var current_coords: Array = current_tiles[layer]
		var prev_coords: Array = previous_tiles.get(layer, [])
		
		# Новые тайлы (entered)
		for coord in current_coords:
			if not prev_coords.has(coord):
				tile_entered.emit(layer, coord)
				print(layer, coord)
		
		# Ушедшие тайлы (exited)
		for coord in prev_coords:
			if not current_coords.has(coord):
				tile_exited.emit(layer, coord)
	
	# Обновляем previous_tiles
	previous_tiles = current_tiles.duplicate(true)

# Метод для получения координат пересекающихся тайлов из всех обнаруженных TileMapLayer
func get_intersecting_tile_coords() -> Dictionary:
	if intersecting_tile_layers.is_empty():
		return {}
	
	# Ищем CollisionShape2D или CollisionPolygon2D (поддержка обоих)
	var collision_node = get_node_or_null("CollisionShape2D")
	if not collision_node:
		collision_node = get_node_or_null("CollisionPolygon2D")
	if not collision_node:
		print("CollisionShape2D или CollisionPolygon2D отсутствует.")
		return {}
	
	var local_points = _generate_local_points_inside_collision(collision_node)
	if local_points.is_empty():
		print("Не удалось сгенерировать точки внутри формы (неподдерживаемая форма или ошибка).")
		return {}
	
	# Преобразуем локальные точки в глобальные (учитывая полный трансформ: позиция, ротация, масштаб)
	var global_points: Array[Vector2] = []
	for local_point in local_points:
		global_points.append(to_global(local_point))
	
	# Словарь для результатов: ключ - TileMapLayer, значение - массив уникальных координат тайлов
	var results: Dictionary = {}  # TileMapLayer -> Array[Vector2i]
	for layer in intersecting_tile_layers:
		results[layer] = []
	
	# Доступ к DirectSpaceState (интерфейс PhysicsServer2D)
	var space_state = get_world_2d().direct_space_state
	
	for global_point in global_points:
		for layer in intersecting_tile_layers:
			# Параметры запроса точки
			var query_params = PhysicsPointQueryParameters2D.new()
			query_params.position = global_point
			query_params.collision_mask = 1 << tilemap_physics_layer  # Используем указанный физический слой
			query_params.collide_with_areas = false
			query_params.collide_with_bodies = true
			
			# Выполняем запрос
			var intersections = space_state.intersect_point(query_params)
			
			if intersections.is_empty():
				continue  # Пропускаем точки без пересечений
			
			for intersection in intersections:
				var collider = intersection.get("collider")
				# Исправление: проверка на StaticBody2D квадрант TileMapLayer
				if (collider is StaticBody2D and collider.get_parent() == layer) or collider == layer:
					var collision_point = intersection.get("position")
					var use_point = global_point  # Используем позицию запроса, если position null
					if collision_point != null:
						use_point = collision_point
					
					# Получаем локальную позицию точки относительно TileMapLayer
					var local_pos = layer.to_local(use_point)
					# Конвертируем в координаты тайла
					var tile_coord = layer.local_to_map(local_pos)
					# Проверяем, что тайл существует (не пустой)
					if layer.get_cell_source_id(tile_coord) != -1:
						# Добавляем в список для слоя, если уникально
						if not results[layer].has(tile_coord):
							results[layer].append(tile_coord)
	
	return results

# Универсальная функция для генерации локальных точек внутри коллизии (поддержка CollisionShape2D и CollisionPolygon2D)
func _generate_local_points_inside_collision(collision_node: Node) -> Array[Vector2]:
	var points: Array[Vector2] = []
	
	if collision_node is CollisionShape2D:
		var shape: Shape2D = collision_node.shape
		if not shape:
			return []
		
		# Получаем AABB формы для генерации точек (локальный bounding box)
		var aabb: Rect2 = shape.get_rect() if shape.has_method("get_rect") else Rect2()
		if aabb.size.x <= 0 or aabb.size.y <= 0:
			return []  # Неподдерживаемая или пустая форма
		
		match shape.get_class():
			"RectangleShape2D":
				var extents = (shape as RectangleShape2D).extents
				var local_min = -extents
				var local_max = extents
				var step_x = (local_max.x - local_min.x) / max(1, sqrt(sample_density) - 1)
				var step_y = (local_max.y - local_min.y) / max(1, sqrt(sample_density) - 1)
				for i in range(sqrt(sample_density)):
					for j in range(sqrt(sample_density)):
						var local_point = Vector2(local_min.x + i * step_x, local_min.y + j * step_y)
						points.append(local_point)
			
			"CircleShape2D":
				var radius = (shape as CircleShape2D).radius
				var num_rings = int(sqrt(sample_density))
				var num_sectors = sample_density / num_rings
				for ring in range(num_rings):
					var ring_radius = radius * sqrt(float(ring) / (num_rings - 1)) if num_rings > 1 else 0
					for sector in range(num_sectors):
						var angle = (sector * TAU) / num_sectors
						var local_point = Vector2(cos(angle), sin(angle)) * ring_radius
						points.append(local_point)
			
			"CapsuleShape2D":
				var height = (shape as CapsuleShape2D).height
				var radius = (shape as CapsuleShape2D).radius
				var num_points_rect = sample_density / 2
				var num_points_caps = sample_density / 2
				# Детерминированная сетка для прямоугольной части
				var rect_width = 2 * radius
				var rect_height = height - 2 * radius
				var step_x = rect_width / sqrt(num_points_rect)
				var step_y = rect_height / sqrt(num_points_rect)
				for i in range(sqrt(num_points_rect)):
					for j in range(sqrt(num_points_rect)):
						var x = -radius + i * step_x
						var y = - (height / 2 - radius) + j * step_y
						points.append(Vector2(x, y))
				# Фиксированные углы для полукругов
				for i in range(num_points_caps / 2):
					var angle = (i * TAU) / (num_points_caps / 2)
					var dist = radius * sqrt(float(i) / (num_points_caps / 2 - 1)) if num_points_caps / 2 > 1 else radius
					points.append(Vector2(cos(angle), sin(angle)) * dist + Vector2(0, height / 2 - radius))
					points.append(Vector2(cos(angle), sin(angle)) * dist + Vector2(0, -height / 2 + radius))
			
			"ConvexPolygonShape2D":
				var polygon_points: PackedVector2Array = (shape as ConvexPolygonShape2D).points
				# Детерминированная сетка в AABB с фильтрацией
				var grid_size = int(sqrt(sample_density))
				var min_x = aabb.position.x
				var min_y = aabb.position.y
				var width = aabb.size.x
				var height = aabb.size.y
				var step_x = width / grid_size
				var step_y = height / grid_size
				for i in range(grid_size):
					for j in range(grid_size):
						var candidate = Vector2(min_x + i * step_x + step_x / 2, min_y + j * step_y + step_y / 2)
						if Geometry2D.is_point_in_polygon(candidate, polygon_points):
							points.append(candidate)
			
			"ConcavePolygonShape2D":
				print("ConcavePolygonShape2D не поддерживается для точного сэмплинга из-за сложной геометрии.")
				return []  # Concave формы требуют разбиения на convex, что выходит за рамки
			
			_:
				print("Форма " + shape.get_class() + " не поддерживается для сэмплинга.")
				return []
	
	elif collision_node is CollisionPolygon2D:
		var polygon_points: PackedVector2Array = collision_node.polygon  # Прямой доступ к points в CollisionPolygon2D
		
		# Вычисляем AABB вручную для CollisionPolygon2D
		var aabb = Rect2()
		if not polygon_points.is_empty():
			aabb = Rect2(polygon_points[0], Vector2.ZERO)
			for point in polygon_points:
				aabb = aabb.expand(point)
		if aabb.size.x <= 0 or aabb.size.y <= 0:
			return []
		
		# Детерминированная сетка в AABB с фильтрацией
		var grid_size = int(sqrt(sample_density))
		var min_x = aabb.position.x
		var min_y = aabb.position.y
		var width = aabb.size.x
		var height = aabb.size.y
		var step_x = width / grid_size
		var step_y = height / grid_size
		for i in range(grid_size):
			for j in range(grid_size):
				var candidate = Vector2(min_x + i * step_x + step_x / 2, min_y + j * step_y + step_y / 2)
				if Geometry2D.is_point_in_polygon(candidate, polygon_points):
					points.append(candidate)
	
	else:
		print("Неподдерживаемый тип коллизии: " + collision_node.get_class())
		return []
	
	return points
