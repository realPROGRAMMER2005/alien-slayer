extends Node


func get_random_position_around(center: Vector2, radius: float) -> Vector2:

	if radius <= 0:
		return center
	
	var angle: float = randf() * TAU  # Случайный угол от 0 до 2π
	var r: float = sqrt(randf()) * radius  # Радиус с корректировкой для равномерности
	var offset: Vector2 = Vector2(cos(angle), sin(angle)) * r
	
	return center + offset
