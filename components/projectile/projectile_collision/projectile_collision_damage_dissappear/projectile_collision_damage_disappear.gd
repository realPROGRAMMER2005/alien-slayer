extends ProjectileCollision
class_name ProjectileCollisionDamageDisappear


@export var damage_component: Damage

func _ready() -> void:
	if not damage_component:
		push_error("Damage component not found!")

func _on_hitbox_entered(target_hitbox_component: Hitbox) -> void:
	target_hitbox_component.health_component.get_damage(damage_component.damage_value)
	owner.queue_free()

func _on_world_entered(body: Node2D) -> void:
	owner.queue_free()
