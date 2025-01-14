extends Projectile
class_name DamageProjectile

@onready var damage: Damage = get_node("Damage")

func on_hit():
	if damage:
		damage.make_damage(target)
	queue_free()
	
