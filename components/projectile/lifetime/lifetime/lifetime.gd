extends Node
class_name Lifetime

@export var lifetime: float = 5
var lifetimer: float = 0


func _process(delta: float) -> void:
	lifetimer += delta
	if lifetimer >= lifetime:
		on_lifetime_out()

func on_lifetime_out():
	pass
