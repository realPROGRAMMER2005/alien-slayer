extends Node
class_name ProjectileMovementParticleSpawner

var level
@export var spawning_interval: float = 0.08
@export var particles_scene: PackedScene
var spawning_interval_timer: float = 0

func _ready() -> void:
	level = Utilities.get_level()

func _physics_process(delta: float) -> void:
	if spawning_interval_timer > spawning_interval and particles_scene:
		var particles_instance = particles_scene.instantiate()
		
		level.add_child(particles_instance)
		particles_instance.global_position = owner.global_position
		particles_instance.emitting = true
		spawning_interval_timer = 0
	spawning_interval_timer += delta
