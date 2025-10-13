extends Node
class_name MovementNode


@export var original_movement_type := MovementSystem.MovementTypes.WALKING
var current_movement_type: MovementSystem.MovementTypes
@export var owner_node: Node2D
var owner_node_velocity: Vector2 = Vector2.ZERO

func move_to_point(target_position: Vector2):
	pass

func _ready() -> void:
	current_movement_type = original_movement_type


func _process(delta: float) -> void:
	if not owner_node:
		owner_node = get_parent()
