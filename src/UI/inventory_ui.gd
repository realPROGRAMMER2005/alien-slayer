extends Control
class_name InventoryUI

var slot_scene = preload("res://src/UI/InventoryItemSlot.tscn")
var slot_quantity = 0
@onready var slot_container = $SlotContainer

func add_item_slot():
	var slot_instance = slot_scene.instantiate()
	slot_container.add_child(slot_instance)
	slot_quantity = slot_container.get_child_count()

func get_item_slot_by_index(item_slot_index):
	slot_container = get_node("SlotContainer")
	return slot_container.get_child(item_slot_index)
		

func apply_selected_style(slot_index):
	get_item_slot_by_index(slot_index).apply_selected_style()

func apply_normal_style(slot_index):
	get_item_slot_by_index(slot_index).apply_normal_style()

func apply_styles(current_item_slot_index):
	for item_slot_index in range(slot_quantity):
		apply_normal_style(item_slot_index)
	apply_selected_style(current_item_slot_index)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
