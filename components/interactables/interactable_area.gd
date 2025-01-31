extends Area2D
class_name InteractArea

@export var interactable_component: Interactable


func _ready() -> void:
	if not interactable_component:
		push_error("Interactable component not found!")
