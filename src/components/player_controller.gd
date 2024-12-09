# PlayerController

"""Компонент, который осуществляет управление игровым персонажем.
Некоторые механики требуют наличия других компонентов.
"""

extends Node
class_name PlayerController

@onready var character: CharacterBody2D = get_parent()

@onready var walk = character.get_node("Walk")
@onready var jump = character.get_node("Jump")


func _process(delta: float) -> void:
	var input_vector = Vector2.ZERO

	# Движение
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1

	if walk:
		walk.update_velocity(input_vector)
		walk.move(delta)


	# Управление прыжком
	if jump:
		if Input.is_action_just_pressed("jump_up") or jump.perform_jump_on_landing:
			jump.jump_start()
		if Input.is_action_pressed("jump_up"):
			jump.jump_hold(delta)
			
		jump.perform_jump_on_landing = false
		if Input.is_action_just_released("jump_up") and not character.is_on_floor():
			jump.jump_end()
			
		if Input.is_action_just_pressed("jump_up") and not jump.is_jumping:
			jump.is_jump_buffered = true
			
