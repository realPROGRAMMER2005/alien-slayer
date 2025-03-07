extends Area2D
class_name ProjectileCollision


var projectile_sender_hitbox: Hitbox
@export var world_impact_particles_scene: PackedScene

func _on_hitbox_entered(target_hitbox_component: Hitbox) -> void:
	pass

func _on_world_entered(body: Node2D) -> void:
	add_world_impact_particles()
	
	

func add_world_impact_particles():
	if world_impact_particles_scene:
		var world_impact_particles_instance = world_impact_particles_scene.instantiate()
		Utilities.get_level().add_child(world_impact_particles_instance)
		world_impact_particles_instance.global_position = global_position
		world_impact_particles_instance.emitting = true
		world_impact_particles_instance.rotation_degrees = owner.rotation_degrees + 180
