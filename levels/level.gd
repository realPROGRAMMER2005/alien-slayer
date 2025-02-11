extends Node2D

@export_enum("Desert") var type: String = "Desert"
var initial_room_scene: PackedScene = load("res://level_objecs/desert/rooms/Room0.tscn")
var room_spawn_chance: float = 1
var room_rects: Array[Rect2] = []
var room_scenes: Array[PackedScene] = [
	load("res://level_objecs/desert/rooms/Room0.tscn"),
	load("res://level_objecs/desert/rooms/Room1.tscn")
]
@export var show_room_rects = false
var value: float = 500
var current_value: float = 0
func _ready() -> void:
	generate()

func _draw() -> void:
	if show_room_rects:
		for room_rect: Rect2 in room_rects:
			draw_rect(room_rect, Color(1, 0, 0))
			
			
func generate():
	var room: Room = initial_room_scene.instantiate()
	add_child(room)
	room.global_position = global_position
	room_rects.append(Rect2(room.global_position.x + room.rect_x, room.global_position.y + room.rect_y, room.rect_width, room.rect_height))	
	var connection_points = room.get_connection_points()
	
	while current_value < value:
		
		var connection_point = connection_points.pick_random()
		connection_points.erase(connection_point)
		if connection_point:
			
			if not connection_point.has_used:
				connection_point.has_used = true
				var allowed_room_scenes: Array[PackedScene] = get_allowed_room_scenes(connection_point)
				
				if allowed_room_scenes.size() > 0:
					room = allowed_room_scenes.pick_random().instantiate()
					add_child(room)
				

					if connection_point.type == "Right":
						room.global_position.x = connection_point.global_position.x + abs(room.global_position.x - room.get_connection_point_by_type("Left").global_position.x)
						room.get_connection_point_by_type("Left").has_used = true
						room.global_position.y = connection_point.global_position.y
						connection_points.erase(room.get_connection_point_by_type("Left"))
					
					if connection_point.type == "Left":
						room.global_position.x = connection_point.global_position.x - room.get_connection_point_by_type("Right").global_position.x
						room.get_connection_point_by_type("Right").has_used = true
						room.global_position.y = connection_point.global_position.y
						connection_points.erase(room.get_connection_point_by_type("Right"))
					
					if connection_point.type == "Top":
						room.global_position.y = connection_point.global_position.y + abs(room.global_position.y - room.get_connection_point_by_type("Bottom").global_position.y)
						room.global_position.x = connection_point.global_position.x
						room.get_connection_point_by_type("Bottom").has_used = true
						connection_points.erase(room.get_connection_point_by_type("Bottom"))
					
					
					if has_overlapping_rooms(room):
						room.queue_free()
						connection_points.append(connection_point)
						connection_point.has_used = false
					else:
						room_rects.append(Rect2(room.global_position.x + room.rect_x, room.global_position.y + room.rect_y, room.rect_width, room.rect_height))
						connection_points += room.get_connection_points()
						current_value += room.value
						connection_points.erase(connection_point)
					
			
		else:
			break			
		
		
		
func get_allowed_room_scenes(connection_point: ConnectionPoint):
	var result: Array[PackedScene] = []
	
	for room_scene: PackedScene in room_scenes:
		var temp_room = room_scene.instantiate()
		
		if temp_room.type in connection_point.allowed_room_types:
			result.append(room_scene)
		temp_room.queue_free()
	
	return result

func has_overlapping_rooms(room: Room):
	for room_rect: Rect2 in room_rects:
		if room_rect.intersects(Rect2(room.global_position.x + room.rect_x, room.global_position.y + room.rect_y, room.rect_width, room.rect_height)):
			return true
	return false
			
		

	
