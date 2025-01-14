# Interactable

"""Компонент, который даёт возможность объекту быть интерактивным"""

extends Node2D
class_name Interactable



@onready var interactable = get_parent()
@onready var interact_area: Area2D = get_parent().get_node("InteractArea")

func _ready() -> void:
	pass

func interact():
	pass
	
func get_interactor_interact_area():
	if interact_area.has_overlapping_areas():
		return interact_area.get_overlapping_areas()[0]
	
