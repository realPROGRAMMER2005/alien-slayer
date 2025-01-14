extends Node
class_name Damage

@export var value: float

func make_damage(target):
	var health = target.get_node_or_null("Health")
	if health:
		health.get_damage(value)
	
