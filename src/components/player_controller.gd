# PlayerController

"""Компонент, который осуществляет 
управление игровым персонажем. Некотоыре механики
требуют наличия других компонентов."""

extends Node
class_name PlayerController

@export var character: CharacterBody2D
var walk: Walk

func _ready() -> void:
	if character:
		walk = character.get_node("Walk")
	

func _process(delta: float) -> void:
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		input_vector.x += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1


	if walk:
		walk.update_velocity(input_vector)
		walk.move(delta) 
