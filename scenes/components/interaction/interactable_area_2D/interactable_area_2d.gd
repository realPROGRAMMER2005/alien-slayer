extends Area2D
class_name InteractableArea2D

@export var interactable_node: InteractableNode


func _process(delta: float) -> void:
	if not interactable_node:
		interactable_node = get_parent().get_node("InteractableNode")
