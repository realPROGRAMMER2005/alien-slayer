# Walk

"""Компонент, который служит для реализации движения
объекта по горизонтали. Не будет работать, если к компоненту, 
к которому он подключён, не подключён компонент Move."""

extends Node
class_name Walk
@onready var character: CharacterBody2D = get_parent()
 

@export var walk_speed: float = 800  # Скорость движения
var velocity = Vector2.ZERO   # Вектор скорости

func update_velocity(input_vector: Vector2) -> void:
	velocity.x = 0  # Сбрасываем скорость
	
	# Применяем скорость в зависимости от направления
	if input_vector.x > 0:
		velocity.x = walk_speed
	elif input_vector.x < 0:
		velocity.x = -walk_speed

func move(_delta: float) -> void:
	if character:
		character.velocity.x = velocity.x

		
