extends Node
class_name Move

@export var character: CharacterBody2D
@export var max_speed: float = 250

func move(direction: Vector2):
	if direction == Vector2.ZERO:
		character.velocity.x = 0
	else:
		character.velocity.x = direction.normalized().x * max_speed
