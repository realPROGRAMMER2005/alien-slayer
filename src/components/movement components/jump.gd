# Jump

"""Компонент, который добавляет персонажу возможность прыжка.
Высота прыжка зависит от времени удержания кнопки. Работает только совместно
с компонентом Gravity
"""
extends CharacterComponent
class_name Jump

@export var jump_strength: float = 150 # Сила прыжка


var current_jump_count: int = 0 # Счетчик прыжков
@export var max_jump_count: int = 1 # Максимальное количество прыжков
var perform_jump: bool = false

func _process(_delta: float) -> void:
	if character.is_on_floor():
		current_jump_count = 0
		
	if perform_jump:
		perform_jump = false
		if current_jump_count < max_jump_count:
			current_jump_count += 1
			character.velocity.y = -jump_strength
		
