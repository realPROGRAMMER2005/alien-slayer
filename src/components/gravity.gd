# Gravity

"""Компонент, который служит для добавления объекту механики падения.
Не будет работать, если к объекту, к которому он подключён, не подключён компонент Move.
"""

extends Node
class_name Gravity

@export var gravity_strength: float = 300 # Сила тяжести
@onready var character: CharacterBody2D = get_parent()
var velocity: Vector2 = Vector2.ZERO  # Вектор скорости

func _process(delta: float) -> void:
	if character:
		
		# Применяем гравитацию только если персонаж не на земле
		if not character.is_on_floor():
			velocity.y += gravity_strength * delta
		else:
			velocity.y = 0  # Сбрасываем вертикальную скорость, когда на земле

		character.velocity.y += velocity.y  # Добавляем скорость вниз
