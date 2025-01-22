extends Projectile
class_name DamageProjectile


func on_hit():
	queue_free()
	
