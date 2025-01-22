extends Node2D
class_name Projectile

@export var hurtbox: Hurtbox

@export var speed: float = 430

func _process(delta):
	if hurtbox:
		if hurtbox.has_hurt:
			on_hit()
	position += transform.x * speed * delta
	

func on_hit():
	pass
	
	
