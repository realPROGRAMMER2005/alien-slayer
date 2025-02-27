extends Node2D
class_name SpawnPoint

@export_range(0.01, 1) var chance_to_spawn: float = 0.5
@export var object_scene: PackedScene

func _ready() -> void:
	spawn()
	
func spawn():
	if object_scene:
		if randf_range(0, 1) < chance_to_spawn:
			var object_instance = object_scene.instantiate()
			Utilities.get_level().add_child(object_instance)
			object_instance.global_position = global_position
