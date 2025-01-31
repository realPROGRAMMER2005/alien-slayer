extends Node2D

@onready var legs_sprite = get_node("Legs/AnimatedSprite2D")
@onready var body_sprite = get_node("Body/AnimatedSprite2D")
@export var controller_component: Node2D
@export var body: CharacterBody2D


func _process(delta: float) -> void:
	if controller_component:
		set_body_frame_by_angle(controller_component.aiming_angle)
	
	if body.velocity.x != 0:
		legs_sprite.play("run")
	else:
		legs_sprite.play("idle")
	
	if body.velocity.x > 0:
		legs_sprite.scale.x = 1
	if body.velocity.x < 0:
		legs_sprite.scale.x = -1
			

func set_body_frame_by_angle(aiming_angle: float) -> void:
	aiming_angle = fmod(aiming_angle + 360, 360)  # Нормализуем угол в диапазон 0-360
	var frame_index = int(round((aiming_angle / 360.0) * 48)) % 48  # Преобразуем угол в индекс кадра
	body_sprite.frame = frame_index

	
		
