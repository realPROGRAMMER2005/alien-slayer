extends Node
class_name Gravity

@export var character: CharacterBody2D
@export var gravity_force: float = 35
@export var max_fall_speed: float = 750
@export var jump_component: Jump
var is_in_jump = false

func _physics_process(delta: float) -> void:
	if not character.is_on_floor():
		character.velocity.y = min(character.velocity.y + gravity_force, max_fall_speed)
	
	if character.is_on_floor() and character.velocity.y > 0:
		character.velocity.y = 0
