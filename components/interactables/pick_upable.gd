extends Interactable
class_name PickUpable

@export var item_component: Item

func get_interacted(interactor: Interactor) -> void:
	get_picked_up(interactor)

func get_picked_up(picker: Interactor) -> void:
	var picker_inventory: Inventory = (Utilities.find_nodes_by_class_name(picker.owner, "Inventory")[0])
	picker_inventory.pick_up_item(item_component)
