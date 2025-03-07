extends Node
class_name Health

@export var max_health: float = 100
var current_health: float = max_health
@export var sprite: Sprite


func get_damage(damage_value: float):
	if sprite:
		sprite.apply_damage_visuals()
	current_health = max(0, current_health - damage_value)
	
	if current_health == 0:
		die()
	print(current_health)
	
func die():
	owner.queue_free()
