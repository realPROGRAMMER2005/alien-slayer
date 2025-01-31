extends Node
class_name Interactor

@export var interactor_area_component: InteractorArea

func _ready() -> void:
	if not interactor_area_component:
		push_error("Interactor area component not found!")

func interact():
	if interactor_area_component.interaction_target_interactable_component:
		interactor_area_component.interaction_target_interactable_component.get_interacted(self)
