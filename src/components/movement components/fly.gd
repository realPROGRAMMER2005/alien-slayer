# Fly
"""Компонент, который служит для реализации движения
персонажа в восьми направлениях с управлением скорости."""
extends CharacterComponent
class_name Fly

@export var flying_speed: float = 200
@export var acceleration: float = 5.0
@export var deceleration: float = 5.0 # Скорость замедления

var velocity: Vector2 = Vector2.ZERO
var target_velocity: Vector2 = Vector2.ZERO



func update_velocity(input_vector: Vector2) -> void:
	# Устанавливаем целевую скорость
	target_velocity = input_vector.limit_length(1.0) * flying_speed

func move(_delta: float) -> void:
	# Плавное изменение скорости
	if target_velocity.length() > 0:
		velocity = velocity.lerp(target_velocity, acceleration * _delta)
	else:
		# Замедление, если нет цели для движения
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * _delta)

	# Применяем скорость к персонажу
	if character:
		character.velocity = velocity
