extends Node2D

@export var groups: Array[String]
@export var trigger_bait: bool = false

func _process(delta: float) -> void:
	if trigger_bait:
		trigger_bait = false
		bait()
	

func bait():
	for group: String in groups:
		var nodes = get_tree().get_nodes_in_group(group)
		if nodes:
			for node in nodes:
				var movement_node: MovementNode = node.find_child("*MovementNode*", false, false)
				
				var controller_node: ControllerNode = node.find_child("*ControllerNode*", false, false)
				
				
				
				if controller_node:
					controller_node.enabled = false
				
				if movement_node:
					movement_node.move_to_point(global_position)
