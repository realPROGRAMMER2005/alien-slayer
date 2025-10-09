extends Node
class_name InteractorNode

@export var interactor_node_owner: Node2D
var current_interactable: InteractableNode

func _process(delta: float) -> void:
	if not interactor_node_owner:
		interactor_node_owner = get_parent()

	if current_interactable:
		if current_interactable.force_interact:
			current_interactable.interact(self)

func interact():
	if current_interactable:
		current_interactable.interact(self)
