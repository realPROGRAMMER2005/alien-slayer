extends Node2D
class_name PlayerController

@export var move_component: Move
@export var jump_component: Jump
@export var muzzle_component: Muzzle
@export var interactor_component: Interactor
@export var inventory_component: Inventory
var aiming_angle = 0

func _process(delta: float) -> void:
	if muzzle_component:
		aiming_angle = (rad_to_deg(muzzle_component.global_position.angle_to_point(get_global_mouse_position())))
		muzzle_component.rotation_degrees = aiming_angle
		
	
	if move_component:
		var direction = Vector2.ZERO
		
		if Input.is_action_pressed("move_right"):
			direction.x += 1
		if Input.is_action_pressed("move_left"):
			direction.x -= 1

		move_component.move(direction)
		
	if jump_component:
		if Input.is_action_just_pressed("jump_up"):
			jump_component.jump()
	
	if interactor_component:
		if Input.is_action_just_pressed("interact"):
			interactor_component.interact()
	
	if inventory_component:
		if Input.is_action_pressed("use_current_item"):
			inventory_component.use_equipped_item()
		
