extends Node2D
class_name NextSegmentPoint

@export var offset_step: int = 16

@export var max_offset_x_in_steps: int = 0
@export var max_offset_y_in_steps: int = 0

func _ready() -> void:
	position.x += randi_range(-max_offset_x_in_steps, max_offset_x_in_steps) * offset_step
	position.y += randi_range(-max_offset_y_in_steps, max_offset_y_in_steps) * offset_step
