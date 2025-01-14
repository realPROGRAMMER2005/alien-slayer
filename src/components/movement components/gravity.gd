# Gravity

"""Компонент, который служит для добавления объекту механики падения.
Не будет работать, если к объекту, к которому он подключён, не подключён компонент Move.
"""

extends CharacterComponent
class_name Gravity

@export var gravity_strength: float = 90 # Сила тяжести
@export var max_falling_speed: float = 800
@onready var jump: Jump = character.get_node_or_null("Jump")
var velocity: Vector2 = Vector2.ZERO  # Вектор скорости

func _process(delta: float) -> void:
	if character:
		# Применяем гравитацию только если персонаж не на земле

		if not character.is_on_floor():
			velocity.y += gravity_strength * delta
			if jump:
				if jump.perform_jump and jump.current_jump_count < jump.max_jump_count:
					velocity.y = 0
		else:
			velocity.y = 0
		
		
		
		character.velocity.y += velocity.y
		if character.velocity.y >= max_falling_speed:
			character.velocity.y = max_falling_speed
