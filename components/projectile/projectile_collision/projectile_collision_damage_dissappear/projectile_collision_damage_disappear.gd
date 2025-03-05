extends ProjectileCollision
class_name ProjectileCollisionDamageDisappear


@export var damage_component: Damage


func _ready() -> void:
	if not damage_component:
		push_error("Damage component not found!")

func _on_hitbox_entered(target_hitbox_component: Hitbox) -> void:
	# Проверяем, что цель не является владельцем снаряда
	if target_hitbox_component and is_instance_valid(target_hitbox_component):
		if target_hitbox_component.health_component and is_instance_valid(target_hitbox_component.health_component):
			if target_hitbox_component != projectile_sender_hitbox:
				target_hitbox_component.health_component.get_damage(damage_component.damage_value)
				owner.queue_free()
		else:
			push_error("Health component is invalid or null!")
	else:
		push_error("Target hitbox component is invalid or null!")


func _on_world_entered(body: Node2D) -> void:
	owner.queue_free()
