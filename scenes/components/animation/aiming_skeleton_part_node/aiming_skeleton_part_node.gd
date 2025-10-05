extends Node
class_name AimingSkeletonPartNode


@export var owner_node: Node2D
var aiming_anlge_degrees: float = 0.0

func _calculate_aim_angle(aim_from_point: Vector2, aim_to_point: Vector2) -> float:
	var target_vector = aim_to_point - aim_from_point  # Вектор от точки прицеливания к цели
	var angle = rad_to_deg(target_vector.angle())  # Угол в градусах относительно оси X
	# Нормализуем угол, чтобы он был в диапазоне [0, 360]
	if angle < 0:
		angle += 360
	return angle


func _process(delta: float) -> void:
	if not owner_node:
		owner_node = get_parent()


func update_aiming(aim_to_point: Vector2):
	aiming_anlge_degrees = _calculate_aim_angle(owner_node.global_position, aim_to_point)
	owner_node.global_rotation_degrees = aiming_anlge_degrees
