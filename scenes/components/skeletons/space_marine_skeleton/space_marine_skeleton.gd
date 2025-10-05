extends Node2D


@onready var legs_animated_sprite_2D = get_node("LegsAnimatedSprite2D")
@onready var body_animated_sprite_2D = get_node("LegsAnimatedSprite2D/BodyAnimatedSprite2D")
@export var character_body_2D: CharacterBody2D
@onready var weapon_skeleton_aiming_part_node: AimingSkeletonPartNode = get_node("LegsAnimatedSprite2D/BodyAnimatedSprite2D/Polygon2D/AimingSkeletonPartNode")



signal animation_signal(animation_name: String)



func _process(delta: float) -> void:
	if not character_body_2D:
		character_body_2D = get_parent()
	

	
	if character_body_2D.is_on_floor():
		
		if character_body_2D.velocity.x != 0:
			animation_signal.emit("move")
			
			if character_body_2D.velocity.x < 0:
				legs_animated_sprite_2D.flip_h = true
			
			else:
				legs_animated_sprite_2D.flip_h = false
				
		
		else:
			animation_signal.emit("idle")
	 
	else:
		if character_body_2D.velocity.y > 0:
			animation_signal.emit("in_air_fall")
		
		else:
			animation_signal.emit("in_air_rise")
	
	body_animated_sprite_2D.frame = _get_frame_index_from_angle(weapon_skeleton_aiming_part_node.aiming_anlge_degrees)
	
	
		
		
	
	
	
func _get_frame_index_from_angle(angle: float) -> int:
	# Всего 48 кадров, каждый кадр покрывает 360 / 48 = 7.5 градусов
	var step = 360.0 / 48.0  # Шаг в градусах на один кадр
	# Вычисляем индекс кадра, начиная с 0 для зеленой линии (0 градусов)
	# Учитываем, что кадры идут "спускаются вниз", то есть против часовой стрелки
	var frame = int(angle / step) % 48
	# Корректировка, чтобы 0 градусов соответствовал первому кадру (зеленая линия)
	return frame
