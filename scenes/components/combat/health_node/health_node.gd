extends Node
class_name HealthNode

@export var health: int = 100
@export_range(0, 100, 1) var damage_resistance: float

signal animation_signal(animation_name: String)


func adjust_health_by_value(value: int):
	pass
