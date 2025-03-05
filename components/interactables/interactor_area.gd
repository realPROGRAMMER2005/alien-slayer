extends Area2D
class_name InteractorArea

var interaction_target_interactable_component: Interactable = null

func _on_area_entered(target_interactable_area_component: InteractArea) -> void:
	interaction_target_interactable_component = target_interactable_area_component.interactable_component

func _on_area_exited(target_interactable_area_component: InteractArea) -> void:
	if interaction_target_interactable_component == target_interactable_area_component.interactable_component:
		interaction_target_interactable_component = null
