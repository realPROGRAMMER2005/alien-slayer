extends Node
class_name InteractorNode

var current_interactable: InteractableNode

func interact():
	current_interactable.interact(self)
