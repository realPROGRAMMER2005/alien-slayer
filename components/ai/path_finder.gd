extends Node2D
class_name Pathfinder

@export var ray_count: int = 16  # Количество лучей для обхода препятствий
@export var ray_spread: float = 360.0  # Угол разброса лучей (в градусах)
@export var min_ray_length: float = 10.0  # Минимальная длина луча
@export var max_ray_length: float = 300.0  # Максимальная длина луча

var target_position: Vector2 = Vector2.ZERO
var rays: Array = []  # Массив для хранения созданных RayCast2D

func _ready():
	# Создаем RayCast2D динамически
	create_rays()

func create_rays():
	for i in range(ray_count):
		var ray = RayCast2D.new()
		ray.enabled = true
		ray.collide_with_areas = true
		ray.collide_with_bodies = true
		add_child(ray)
		rays.append(ray)

func find_path_to(target: Vector2) -> Array:
	target_position = target
	var path = []
	var current_position = global_position

	while current_position.distance_to(target_position) > 10.0:
		var direction = (target_position - current_position).normalized()
		var ray_length = max_ray_length

		# Проверяем, есть ли препятствие на пути
		var ray = get_closest_ray(direction)
		ray.target_position = direction * ray_length
		ray.force_raycast_update()

		if ray.is_colliding():
			# Если есть препятствие, уменьшаем длину луча до расстояния до препятствия
			ray_length = current_position.distance_to(ray.get_collision_point())
			ray.target_position = direction * ray_length
			ray.force_raycast_update()

			# Ищем обходной путь
			var avoidance_vector = find_avoidance_vector(current_position, direction, ray_length)
			var next_position = current_position + avoidance_vector * ray_length
			path.append(next_position)
			current_position = next_position
		else:
			# Если препятствий нет, двигаемся к цели
			var next_position = current_position + direction * ray_length
			path.append(next_position)
			current_position = next_position

	return path

func get_closest_ray(direction: Vector2) -> RayCast2D:
	var closest_ray = rays[0]
	var smallest_angle = INF

	for ray in rays:
		var ray_direction = ray.target_position.normalized()
		var angle = direction.angle_to(ray_direction)
		if abs(angle) < abs(smallest_angle):
			smallest_angle = angle
			closest_ray = ray

	return closest_ray

func find_avoidance_vector(current_position: Vector2, direction: Vector2, ray_length: float) -> Vector2:
	var best_direction = Vector2.ZERO
	var best_distance = INF

	for ray in rays:
		var ray_direction = ray.target_position.normalized()
		ray.target_position = ray_direction * ray_length
		ray.force_raycast_update()

		if not ray.is_colliding():
			var distance = current_position.distance_to(target_position)
			if distance < best_distance:
				best_distance = distance
				best_direction = ray_direction

	return best_direction
