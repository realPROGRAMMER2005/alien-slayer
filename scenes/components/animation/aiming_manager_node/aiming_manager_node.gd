extends Node
class_name AimingManagerNode

@export var aim_to_point: Vector2 = Vector2.ZERO
@export var trigger_aiming: bool = false
@export var trigger_update_aiming_skeleton_part_nodes: bool = true
@export var aiming_skeleton_part_nodes: Array[Node] = []
var aiming_anlge_degress: float = 0.0

func _process(delta: float) -> void:
	if trigger_update_aiming_skeleton_part_nodes:
		trigger_update_aiming_skeleton_part_nodes = false
		_update_aiming_skeleton_parts()
	
	if trigger_aiming: 
		trigger_aiming = false
		_update_aiming()
		




func _update_aiming_skeleton_parts():
	aiming_skeleton_part_nodes = get_parent().find_children("*", "AimingSkeletonPartNode", true, false)

func _update_aiming():
	for node: AimingSkeletonPartNode in aiming_skeleton_part_nodes:
		node.update_aiming(aim_to_point)
		
	
	
