extends Node2D
class_name Level

var has_ground: bool = true
var next_ground_room_position = Vector2(-5000, 0)
var ground_length_in_rooms: int = 300


var ground_room_scenes: Array[PackedScene]

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass


func generate_level():
	pass
	
func generate_ground():
	if has_ground:
		for i in range(ground_length_in_rooms):
			var ground_room_scene: PackedScene = ground_room_scenes.pick_random()
			
			
		
		
