extends Node
class_name InteractorNode

var current_interactable: InteractableNode

func interact():
	print(current_interactable)
	if current_interactable:
		current_interactable.interact(self)
