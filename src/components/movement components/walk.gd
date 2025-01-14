# Walk

"""Компонент, который служит для реализации движения
персонажа по горизонтали."""

extends CharacterComponent
class_name Walk
 

@export var walk_speed: float = 200
var velocity = Vector2.ZERO 

func update_velocity(input_vector: Vector2) -> void:
	velocity.x = 0  # Сбрасываем скорость
	
	if input_vector.x > 0:
		velocity.x = walk_speed
	elif input_vector.x < 0:
		velocity.x = -walk_speed

func move(_delta: float) -> void:
	if character:
		character.velocity.x = velocity.x

func set_walking_speed(new_speed: float):
	walk_speed = new_speed

		
