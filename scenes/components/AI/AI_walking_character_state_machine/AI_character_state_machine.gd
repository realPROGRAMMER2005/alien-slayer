extends FiniteStateMachineNode
class_name AICharacterStateMachineNode


@export var movement_node: MovementNode
@export var is_enabled: bool = true
@export var aiming_manager_node: AimingManagerNode
			

func _process(delta: float):
	if not movement_node:
			movement_node = get_parent().find_child("*MovementNode*", false, false)
			
	if not aiming_manager_node:
		aiming_manager_node = get_parent().get_node("AimingManagerNode")
	
	if is_enabled:
	
		super._process(delta)
		
