# Health

"""Компонент, который добавляет персонажу здоровье и 
возможность получать урон"""

extends CharacterComponent
class_name  Health

@export var max_health: float = 100
var current_health: float

func _ready() -> void:
	current_health = max_health

func get_damage(damage: int):
	current_health -= damage
	if current_health <= 0:
		die()

func die():
	character.queue_free()
