extends ControllerNode
class_name PlayerControllerNode

@export var movement_node: CharacterBody2DMovementNode
@export var aiming_manager_node: AimingManagerNode
@export var interactor_node: InteractorNode
@export var owner_node: Node2D
@export var enabled: bool = true

func _process(delta: float) -> void:
	if not movement_node:
		movement_node = get_parent().get_node("CharacterBody2DMovementNode")
		
	if not aiming_manager_node:
		aiming_manager_node = get_parent().get_node("AimingManagerNode")
		
	if not interactor_node:
		interactor_node = get_parent().get_node("InteractorNode")
	
	if not owner_node:
		owner_node = get_parent()

func _physics_process(_delta: float) -> void:
	if movement_node:

		var move: Vector2 = Vector2.ZERO
		move.x = Input.get_axis("move_left", "move_right")
		move.y = Input.get_axis("move_up", "move_down")

		movement_node.set_move(move)

		if Input.is_action_just_pressed("jump"):
			movement_node.jump()
	
	if aiming_manager_node and owner_node:
		aiming_manager_node.aim_to_point = owner_node.get_global_mouse_position()
		aiming_manager_node.trigger_aiming = true
	
	
	if interactor_node:
		if Input.is_action_just_pressed("interact"):
			interactor_node.interact()
