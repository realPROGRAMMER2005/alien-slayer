# Health

"""Компонент, который добавляет персонажу здоровье и 
возможность получать урон"""

extends Node
class_name  Health

@onready var parent = get_parent()

@export var health: float = 100


func get_damage(damage: int):
	health -= damage
	if health <= 0:
		die()

func die():
	pass