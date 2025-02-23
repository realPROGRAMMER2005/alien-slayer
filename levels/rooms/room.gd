extends Node2D
class_name Room

@onready var room_area = $RoomArea
var spawn_points: Array[SpawnPoint] = []

func setup_room_spawn_points():
	spawn_points = Utilities.find_nodes_by_class_name(self, SpawnPoint)

func generate():
	pass

func _ready() -> void:
	setup_room_collision_shape()

func setup_room_collision_shape():
	var tile_map_layers: Array = Utilities.find_nodes_by_class_name(self, TileMapLayer)

	if tile_map_layers.is_empty():
		return  # Если слоев нет, не создаем коллизию

	var tile_size: Vector2i = tile_map_layers[0].tile_set.tile_size  # Размер одного тайла

	# Инициализируем начальные значения для общего прямоугольника
	var total_rect: Rect2i = Rect2i()

	# Проходим по всем слоям и находим общий прямоугольник
	for tile_map_layer in tile_map_layers:
		var rect: Rect2i = tile_map_layer.get_used_rect()
		rect.position *= tile_size  # Переводим в пиксели
		rect.size *= tile_size

		if total_rect.has_area():
			total_rect = total_rect.merge(rect)
		else:
			
			total_rect = rect

	# Создаем или находим CollisionShape2D
	var collision_shape: CollisionShape2D
	if room_area.has_node("CollisionShape2D"):
		collision_shape = $CollisionShape2D
	else:
		collision_shape = CollisionShape2D.new()
		collision_shape.name = "CollisionShape2D"
		room_area.add_child(collision_shape)

	var shape := RectangleShape2D.new()
	shape.size = total_rect.size

	collision_shape.shape = shape
	collision_shape.position = total_rect.position + total_rect.size / 2  # Центрируем коллизию
