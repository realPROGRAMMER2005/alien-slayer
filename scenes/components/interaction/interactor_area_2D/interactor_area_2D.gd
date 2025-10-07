extends Area2D
class_name InteractorArea2D


@export var interactor_node: InteractorNode

func _process(delta: float) -> void:
	if not interactor_node:
		interactor_node = get_parent().get_node("InteractorNode")


func _on_interactable_area_2D_entered(interactable_area_2D: InteractableArea2D) -> void:
	if interactor_node:
		interactor_node.current_interactable = interactable_area_2D.interactable_node
	
	
func _on_interactable_area_2D_exited(interactable_area_2D: InteractableArea2D) -> void:
	if interactor_node:
		if interactable_area_2D.interactable_node == interactor_node.current_interactable:
			interactor_node.current_interactable = null
