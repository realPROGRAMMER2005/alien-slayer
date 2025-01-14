extends Area2D
class_name Projectile

var target: Node2D = null

@export var speed: float = 750

func _process(delta):
	position += transform.x * speed * delta
	
	if has_overlapping_bodies():
		target = get_overlapping_bodies()[0]
		on_hit()
	

func on_hit():
	pass
	
	
