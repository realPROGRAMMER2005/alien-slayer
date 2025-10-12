extends Node
class_name MovementNode


@export var original_movement_type := MovementSystem.MovementTypes.WALKING
var current_movement_type: MovementSystem.MovementTypes


func move_to_point(target_position: Vector2):
	pass

func _ready() -> void:
	current_movement_type = original_movement_type
