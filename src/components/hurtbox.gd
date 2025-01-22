extends Area2D
class_name Hurtbox

@export var damage: Damage
var damage_value: float = 10
@export var has_make_damage_after_first_hit: bool = false
var has_hurt = false


func _ready() -> void:
		
	if damage:
		damage_value = damage.value

	


func _process(delta: float) -> void:
	if has_overlapping_bodies():
		has_hurt = true
	
func make_damage(health_node: Health) -> void:
	if health_node:
		if is_instance_valid(health_node):
			health_node.get_damage(damage_value)
	
