# PlayerController

"""Компонент, который осуществляет управление игровым персонажем.
Некоторые механики требуют наличия других компонентов.
"""

extends CharacterComponent
class_name PlayerController


@onready var walk: CharacterComponent = character.get_node("Walk")
@onready var jump: CharacterComponent = character.get_node("Jump")
@onready var inventory: Inventory = character.get_node("Inventory")
@onready var interact_area: Area2D = character.get_node("InteractArea")

signal current_item_used

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

	# Обработка прыжка
	if Input.is_action_just_pressed("jump_up") and jump:
		jump.perform_jump = true
	
	if Input.is_action_just_pressed("switch_current_item_up") and inventory:
		inventory.switch_current_item_previous()
	
	if Input.is_action_just_pressed("switch_current_item_down") and inventory:
		inventory.switch_current_item_next()
		
	if Input.is_action_pressed("use_current_item"):
		emit_signal("current_item_used")
	
	
		
	interact_area.global_position = interact_area.get_global_mouse_position()
	if Input.is_action_just_pressed("interact"):
		if interact_area.has_overlapping_areas():
			var interactable: Interactable = interact_area.get_overlapping_areas()[0].get_parent().get_node_or_null("Interactable")
			interactable.interact()
	
				
			
			
	
