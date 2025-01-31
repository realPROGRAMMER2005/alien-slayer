extends Area2D
class_name Hitbox

@export var health_component: Health


func _ready() -> void:
	if not health_component:
		push_error("Health component not found!")


func _process(delta: float) -> void:
	pass
