extends Node
class_name InteractableNode

signal animation_signal(animation_name)

@export var force_interact: bool = false
@export var interacting_groups: Array[String]

func interact(interactor_node: InteractorNode):
	if not check_if_can_interact(interactor_node):
		return


func check_if_can_interact(interactor_node):
	return interacting_groups and interactor_node.interactor_node_owner.get_groups().any(func(x): return x in interacting_groups)
