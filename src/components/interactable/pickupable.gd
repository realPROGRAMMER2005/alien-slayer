# Pickupable

"""Компонент, который позволяет объекту быть подбираем в инвентарь."""

extends Interactable
class_name Pickupable




@export var item_scene: PackedScene

func get_interactor_inventory():
	return get_interactor_interact_area().get_parent().get_node_or_null("Inventory")


func interact():
	get_picked_up()
	
func get_picked_up():
	get_interactor_inventory().get_child(0).add_child(item_scene.instantiate())
	get_parent().queue_free()
