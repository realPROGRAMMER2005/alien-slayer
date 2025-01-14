extends CharacterComponent
class_name Inventory





@export var capacity: int = 6
var current_item_index: int = 0
var previous_item_index: int = 1
var items: Array = []
var inventory_UI: InventoryUI
@onready var quick_access_node: Node = get_node("QuickAccess")


signal item_used
signal current_item_switched

func _process(_delta: float) -> void:
	update_items_array()
	

func update_items_array():
	for item: Item in quick_access_node.get_children():
		if item not in items:
			add_item_to_array(item)
		
func _ready() -> void:
	for index in range(capacity):
		items.append(null)

	if character.has_node("PlayerController"):
		character.get_node("PlayerController").current_item_used.connect(use_current_item)
		connect_to_UI()
		update_inventory_UI()



func use_current_item():
	
	emit_signal("item_used", items[current_item_index])
	if items[current_item_index]:
		items[current_item_index].use()


func get_items_count():
	var items_quantity = 0
	for item in items:
		if item is Item:
			items_quantity += 1
	return items_quantity


func add_item_to_array(item):
	for index in range(capacity):
		if items[index] is not Item:
			items[index] = item
			break
	switch_current_item(current_item_index)
	update_inventory_UI()
	

		
func switch_current_item_previous():
	previous_item_index = current_item_index
	current_item_index -= 1
	if current_item_index == -1:
		current_item_index = capacity - 1
	update_inventory_UI()
	emit_signal("current_item_switched", items[current_item_index], items[previous_item_index])

func switch_current_item_next():
	previous_item_index = current_item_index
	current_item_index += 1
	if current_item_index == capacity:
		current_item_index = 0
	update_inventory_UI()
	emit_signal("current_item_switched", items[current_item_index], items[previous_item_index])

func switch_current_item(item_index):
	current_item_index = item_index
	if current_item_index < 0:
		current_item_index = 0
	elif current_item_index >= capacity:
		current_item_index = capacity - 1
	update_inventory_UI()
	emit_signal("current_item_switched", items[current_item_index], null)

func connect_to_UI():
	inventory_UI = get_tree().root.get_node_or_null("Main/UI/InventoryUI")
	


func update_inventory_UI():
	if inventory_UI:
		while inventory_UI.slot_quantity < capacity:
			inventory_UI.add_item_slot()
	
		
		for item_index in range(capacity):
			print(inventory_UI.get_item_slot_by_index(item_index).item)
			inventory_UI.get_item_slot_by_index(item_index).item = items[item_index]
		
		inventory_UI.apply_styles(current_item_index)
		
			
	

	
