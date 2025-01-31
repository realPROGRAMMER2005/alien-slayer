extends Node
class_name Inventory

var items: Array
@export var max_item_stacks = 1
var current_item_stacks_quantity = 0
var equipped_item_index: int = 0

func _ready() -> void:
	init_items_array()

func update_item_stacks_quantity():
	var result = 0
	for item_stack_index: int in range(max_item_stacks):
		if items[item_stack_index] != null:
			result += 1
	return result
		

func init_items_array() -> void:
	for i in range(max_item_stacks):
		items.append(null)
	update_item_stacks_quantity()

func equip_item_by_index(item_index_to_equip: int):
	equipped_item_index = item_index_to_equip
	if items[equipped_item_index] != null:
		items[equipped_item_index].get_equipped()

func pick_up_item(new_item: Item):
	current_item_stacks_quantity += 1
	
	if current_item_stacks_quantity > max_item_stacks:
		drop_item_by_index(0)
	
	new_item.get_in_inventory(self)
	append_item_to_array(new_item)
	update_item_stacks_quantity()
	

func append_item_to_array(new_item: Item):
	for item_stack_index in range(max_item_stacks):
		if items[item_stack_index] == null:
			items[item_stack_index] = new_item

func remove_item_from_array_by_index(item_to_remove_index: int) -> void:
	items[item_to_remove_index] = null

func drop_item_by_index(item_to_drop_index: int) -> void:
	var item_to_drop: Item = items[item_to_drop_index]
	item_to_drop.get_dropped(owner.global_position)
	remove_item_from_array_by_index(item_to_drop_index)
	update_item_stacks_quantity()
	

func use_equipped_item() -> void:
	if items[equipped_item_index] != null:
		items[equipped_item_index].use()
	
