extends Area2D
class_name Hitbox

@export var health: Health
var damaged_by: Array[Hurtbox] = []

func _ready() -> void:
	set_collision_layer_value(6, true)

func _process(delta: float) -> void:
	if health:
		if is_instance_valid(health):
			for hurtbox: Hurtbox in get_overlapping_areas():
				if hurtbox not in damaged_by:
						hurtbox.make_damage(health)
						damaged_by.append(hurtbox)
						print('asdasd')



		
