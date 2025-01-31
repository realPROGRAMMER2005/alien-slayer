extends Area2D
class_name Bullet

@export var max_life_time: float = 10
var life_timer: float = 0

func on_hit_hitbox(kwargs: Dictionary = {}):
	pass

func on_life_time_out():
	pass

func on_hit_wall():
	pass

func _on_area_entered(area: Area2D) -> void:
	on_hit_hitbox({"hitbox": area})

func _process(delta: float) -> void:
	life_timer += delta
	if life_timer >= max_life_time:
		on_life_time_out()


func _on_body_entered(_body: Node2D) -> void:
	on_hit_wall()
