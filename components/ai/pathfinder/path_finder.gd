extends Node2D
class_name Pathfinder

@export var ray_count: int = 8  # Количество лучей для обхода препятствий
@export var ray_spread: float = 90.0  # Угол разброса лучей (в градусах)
@export var ray_length: float = 30  # Длина лучей

var target_position: Vector2 = Vector2.ZERO
var rays: Array = []  # Массив для хранения созданных RayCast2D
var current_direction: Vector2 = Vector2.ZERO  # Текущее направление движения
var is_avoiding: bool = false  # Флаг, указывающий, что мы обходим препятствие

func _ready():
	# Создаем RayCast2D динамически
	create_rays()

func create_rays():
	for i in range(ray_count):
		var ray = RayCast2D.new()
		ray.enabled = true
		ray.collide_with_areas = true
		ray.collide_with_bodies = true
		add_child(ray)
		rays.append(ray)

# Установить цель
func set_target(target: Vector2):
	target_position = target
	current_direction = (target_position - global_position).normalized()

# Получить направление движения
func get_movement_direction() -> Vector2:
	# Проверяем, есть ли препятствие в текущем направлении
	var main_ray = rays[0]
	main_ray.target_position = current_direction * ray_length
	main_ray.force_raycast_update()

	if main_ray.is_colliding():
		# Если есть препятствие, начинаем обход
		is_avoiding = true
		return find_avoidance_direction()
	else:
		# Если препятствий нет, двигаемся к цели
		is_avoiding = false
		return current_direction

# Найти направление для обхода препятствия
func find_avoidance_direction() -> Vector2:
	var best_direction = Vector2.ZERO
	var smallest_angle = INF

	for i in range(ray_count):
		var angle = deg_to_rad(-ray_spread / 2 + i * (ray_spread / (ray_count - 1)))
		var ray_direction = current_direction.rotated(angle)
		rays[i].target_position = ray_direction * ray_length
		rays[i].force_raycast_update()

		if not rays[i].is_colliding():
			# Выбираем направление, которое ближе к текущему направлению
			var angle_to_current = abs(ray_direction.angle_to(current_direction))
			if angle_to_current < smallest_angle:
				smallest_angle = angle_to_current
				best_direction = ray_direction

	return best_direction
