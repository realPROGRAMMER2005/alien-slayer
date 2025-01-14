extends Node
class_name Item

@export var title: String = "Item"
@export var description: String = "Just an item."
@export var is_stackable: bool = true
@export_range(1, 999) var max_stack_quantiy: int = 999
@export_range(1, 999) var current_stack_quantity: int = 1

@export var equipped_scene: PackedScene
@export var inventory_icon: Texture2D


func use():
	pass
	

func get_inventory_owner():
	return get_parent().get_parent().get_parent()
