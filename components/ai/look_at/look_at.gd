extends Node2D
class_name LookAt

var target: Node2D
var muzzle_component: Muzzle

func _process(delta: float) -> void:
	if target:
		# Получаем вектор направления к цели
		var direction: Vector2 = target.global_position - global_position
		# Нормализуем вектор, чтобы получить только направление
		direction = direction.normalized()
		var angle: float = Vector2.RIGHT.angle_to(direction)
		
		global_rotation = angle
		

func get_look_at_angle():
	return global_rotation
