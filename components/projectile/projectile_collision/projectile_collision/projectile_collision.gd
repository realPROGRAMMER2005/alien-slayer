extends Area2D
class_name ProjectileCollision

var projectile_sender_hitbox: Hitbox

func _on_hitbox_entered(target_hitbox_component: Hitbox) -> void:
	pass

func _on_world_entered(body: Node2D) -> void:
	pass
