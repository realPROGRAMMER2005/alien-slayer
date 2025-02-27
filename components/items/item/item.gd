extends Node
class_name Item

@export var item_title: String = "Item"
@export var max_in_stack_quantity: int = 1
var item_owner: Node2D = null

func get_dropped(drop_position: Vector2):
	owner.position = Vector2.ZERO
	owner.set_visible(true)
	owner.freeze = false
	owner.reparent(Utilities.get_level())
	owner.global_position = drop_position

func get_equipped():
	pass

func update_item_owner():
	item_owner = Utilities.find_owner_by_class(self, CharacterBody2D)
	print(item_owner)
	
func get_in_inventory(inventory: Inventory):
	owner.set_visible(false)
	owner.freeze = true
	owner.global_position = inventory.owner.global_position
	owner.reparent(inventory)
	owner.position = Vector2.ZERO
	update_item_owner()

func use():
	pass
