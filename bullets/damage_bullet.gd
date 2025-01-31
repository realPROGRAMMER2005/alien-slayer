extends Bullet
class_name DamageBullet

@export var damage_value: float = 20

func on_hit_hitbox(kwargs: Dictionary = {}):
	var hitbox: Hitbox = kwargs.get("hitbox")
	if hitbox:
		hitbox.health_component.take_damage(damage_value)
	queue_free()
	
func on_hit_wall():
	queue_free()

func on_life_time_out():
	queue_free()
