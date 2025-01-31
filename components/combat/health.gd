extends Node
class_name Health

@export var max_health: float = 100
var current_health: float = max_health

func get_damage(damage_value: float):
	current_health = max(0, current_health - damage_value)
	if current_health == 0:
		die()
	
func die():
	queue_free()
