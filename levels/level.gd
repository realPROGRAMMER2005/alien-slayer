extends Node2D
class_name Level

@export var has_ground: bool = true
var next_ground_room_position = Vector2(-5000, 0)
@export var platform_rooms_scenes: Array[PackedScene]
var ground_length_in_rooms: int = 30
@onready var rooms_separator: Node2D = $Rooms
var rooms_list: Array[Room] = []
@export var has_platforms: bool = false
@export var ground_height_variation: int = 40

@export var ground_room_scenes: Array[PackedScene]

# Максимальное количество платформ
@export var max_platforms: int = 100
var platforms_created: int = 0

func _ready() -> void:
	generate_ground()
	generate_platforms()

func generate_ground():
	if not has_ground:
		return
	for i in range(ground_length_in_rooms):
		var ground_room_scene: PackedScene = ground_room_scenes.pick_random()
		var ground_room_instance: Room = ground_room_scene.instantiate()
		rooms_separator.add_child(ground_room_instance)
		rooms_list.append(ground_room_instance)
		ground_room_instance.global_position = next_ground_room_position
		next_ground_room_position.x += ground_room_instance.room_width
		next_ground_room_position.y += 16 * randi_range(-5, ground_height_variation)

func generate_platforms():
	if not has_platforms:
		return
	# Ограничиваем количество платформ
	while platforms_created < max_platforms:
		var room: Room = rooms_list[platforms_created % rooms_list.size()]  # Перебираем комнаты по кругу
		var platform_added: bool = try_add_platform(room)

		if not platform_added:
			# Если не удалось добавить платформу, увеличиваем счетчик, чтобы избежать бесконечного цикла
			platforms_created += 1

func try_add_platform(room: Room) -> bool:
	# Определяем позиции для платформ относительно текущей комнаты
	var platform_positions = [
		Vector2(room.global_position.x + room.room_width, room.global_position.y),  # Справа от комнаты
		Vector2(room.global_position.x - room.room_width, room.global_position.y),  # Слева от комнаты
		Vector2(room.global_position.x, room.global_position.y + room.room_height), # Сверху от комнаты
		Vector2(room.global_position.x, room.global_position.y - room.room_height)  # Снизу от комнаты
	]

	# Перемешиваем позиции, чтобы добавлять платформы в случайном порядке
	platform_positions.shuffle()

	# Пытаемся добавить платформу в одну из позиций
	for position in platform_positions:
		if not is_position_colliding(position):
			var platform_scene: PackedScene = platform_rooms_scenes.pick_random()
			var platform_instance: Room = platform_scene.instantiate()
			rooms_separator.add_child(platform_instance)
			platform_instance.global_position = position
			rooms_list.append(platform_instance)
			platforms_created += 1
			return true

	return false

func is_position_colliding(position: Vector2) -> bool:
	# Проверяем, пересекается ли новая позиция с существующими комнатами
	for existing_room in rooms_list:
		var room_rect = Rect2(existing_room.global_position, Vector2(existing_room.room_width, existing_room.room_height))
		var new_room_rect = Rect2(position, Vector2(existing_room.room_width, existing_room.room_height))

		if room_rect.intersects(new_room_rect):
			return true
	return false
