extends Node
class_name Shoot

@export var muzzle_component: Muzzle
@export var default_bullet_scene: PackedScene
var current_bullet_scene: PackedScene
@export var fire_rate: float = 0.2
var fire_rate_timer = fire_rate

func _process(delta: float) -> void:
	fire_rate_timer += delta

func _ready() -> void:
	if not current_bullet_scene:
		current_bullet_scene = default_bullet_scene

func shoot():
	if fire_rate_timer >= fire_rate:
		if current_bullet_scene and muzzle_component:
			var bullet = current_bullet_scene.instantiate()
			if bullet is Node2D:
				bullet.global_position = muzzle_component.global_position
				bullet.global_rotation = muzzle_component.global_rotation
				get_tree().current_scene.add_child(bullet)

func change_bullet_scene(new_bullet_scene: PackedScene):
	current_bullet_scene = new_bullet_scene
