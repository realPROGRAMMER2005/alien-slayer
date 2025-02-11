extends Node
class_name Jump

@export var character: CharacterBody2D
@export var jump_force: float = 420
@export var max_jump_count: int = 2
var current_jump_count: int = 0


func _physics_process(delta: float) -> void:
	if character.is_on_floor() and character.velocity.y == 0:
		current_jump_count = 0
	
	
	
func jump():
	if current_jump_count < max_jump_count:
		character.velocity.y = -jump_force
		current_jump_count += 1
