# Interactable

"""Компонент, который даёт возможность объекту быть интерактивным"""

extends Node2D
class_name Interactable



@export var interactable: Node2D
@export var interact_area: Area2D

func _ready() -> void:
	pass

func interact():
	pass
	
func get_interactor_interact_area():
	print(interact_area.get_overlapping_areas())
	if interact_area.has_overlapping_areas():
		return interact_area.get_overlapping_areas()[0]
	
