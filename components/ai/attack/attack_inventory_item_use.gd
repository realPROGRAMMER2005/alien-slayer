extends Attack
class_name AttackInventoryItemUse

@export var attacker_inventory_component: Inventory



func _process(delta: float) -> void:
	super(delta)
	if is_attacking and attacker_inventory_component and look_at_component:
		if attacker_inventory_component.get_equipped_item():
			attacker_inventory_component.get_equipped_item().use()
	
