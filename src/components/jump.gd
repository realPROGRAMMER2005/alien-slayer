# Jump

"""Компонент, который добавляет персонажу возможность прыжка.
Высота прыжка зависит от времени удержания кнопки. Работает только совместно
с компонентом Gravity
"""

extends Node
class_name Jump

@export var jump_strength: float = 450 # Начальная сила прыжка
@export var max_jump_time: float = 0.3 # Максимальное время удержания кнопки
@export var max_jumps: int = 1  # Максимальное количество прыжков
@onready var character: CharacterBody2D = get_parent()
var apply_gravity: bool = true
var is_jump_buffered: bool = false
var jump_buffer_max_time: float = 0.2
var jump_buffer_current_time: float = 0
var perform_jump_on_landing: bool = false



var is_jumping: bool = false  # Флаг, указывающий, находится ли персонаж в состоянии прыжка
var jump_time: float = 0.0  # Текущее время прыжка
var current_jump_strength: float = 0.0  # Текущая сила прыжка, которая будет увеличиваться
var current_jumps: int = 0  # Счётчик оставшихся прыжков

func _process(delta: float) -> void:
	
	
	if is_jump_buffered:
		jump_buffer_current_time += delta
		if character.is_on_floor() and jump_buffer_max_time >= jump_buffer_current_time:
			jump_buffer_current_time = 0
			is_jump_buffered = false
			perform_jump_on_landing = true
		


func jump_start() -> void:

	
	# Начинаем прыжок, если персонаж на земле или у него есть доступные дополнительные прыжки
	if character and (character.is_on_floor() or current_jumps < max_jumps):
		if character.is_on_floor():
			current_jumps = 0
			  # Сбрасываем счётчик прыжков при касании земли
		is_jumping = true
		apply_gravity = false
		jump_time = 0.0
		current_jump_strength = jump_strength  # Начальная сила прыжка
		character.velocity.y = -current_jump_strength
		current_jumps += 1  # Увеличиваем счётчик прыжков
		
	
		
func jump_hold(delta: float) -> void:
	# Поддерживаем прыжок, пока удерживается кнопка
	if is_jumping and jump_time < max_jump_time:
		jump_time += delta
		# Увеличиваем силу прыжка по мере удержания кнопки, что ускоряет подъем
		current_jump_strength = jump_strength + (jump_strength * (jump_time / max_jump_time))
		character.velocity.y = -current_jump_strength
	else:
		apply_gravity = true
		

func jump_end() -> void:
	# Завершаем прыжок
	is_jumping = false
	apply_gravity = true
	jump_buffer_current_time = 0
