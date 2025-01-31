extends Area2D
class_name Hurtbox


@export var damage_component: Damage

func _ready() -> void:
	if not damage_component:
		push_error("Damage component not found!")


func _on_hitbox_area_entered(target_hitbox_component: Hitbox) -> void:
	target_hitbox_component.health_component.get_damage(25)
