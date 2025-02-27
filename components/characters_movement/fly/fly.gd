extends Node
class_name Fly

@export var character: CharacterBody2D
@export var max_speed: float = 250 

func fly(direction: Vector2):
	if direction == Vector2.ZERO:
		character.velocity = Vector2.ZERO
	else:
		character.velocity = direction.normalized() * max_speed
