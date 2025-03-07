extends Node2D
class_name Sprite

@export var sprite_parts: Array[Node2D] = []
@export var damage_color: Color = Color.WHITE
@export var damage_color_applying_duration: float = 0.2
var damage_color_applying_timer: float = 0
var damage_visuals_applied: bool = false

func apply_damage_visuals():
	for sprite_part in sprite_parts: 
		sprite_part.material.set_shader_parameter("enabled", true)
		damage_visuals_applied = true

func remove_damage_visuals():
	for sprite_part in sprite_parts:
		sprite_part.material.set_shader_parameter("enabled", false)
		damage_visuals_applied = false
		
func _process(delta: float) -> void:
	if damage_visuals_applied:
		damage_color_applying_timer += delta
		if damage_color_applying_timer > damage_color_applying_duration:
			damage_color_applying_timer = 0
			remove_damage_visuals()
	
	
		
