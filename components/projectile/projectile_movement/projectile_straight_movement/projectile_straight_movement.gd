extends ProjectileMovement
class_name ProjectileStraightMovement

func _process(delta: float) -> void:
	owner.velocity = direction * speed
	owner.move_and_slide()

	
