extends Node2D
class_name PlayerSpawnPoint


@export var character_scene: PackedScene
@export var camera_scene: PackedScene

func spawn_player():
	var character_instance = character_scene.instantiate()
	var level: Level = Utilities.get_level()
	level.add_child(character_instance)
	character_instance.global_position = global_position
	character_instance.add_child(camera_scene.instantiate())
	
	
func _ready() -> void:
	spawn_player() 
