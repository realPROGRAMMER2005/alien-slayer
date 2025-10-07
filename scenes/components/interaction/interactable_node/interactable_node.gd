extends Node
class_name InteractableNode

signal animation_signal(animation_name)

func interact(interactor):
	animation_signal.emit("interact")
