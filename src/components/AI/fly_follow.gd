# FlyFollow
"""Компонент, который заставляет персонажа следовать за случайной точкой в области вокруг цели."""
extends CharacterComponent
class_name FlyFollow

@export var target: Node2D
@export var follow_radius_area: float = 140 # Радиус области вокруг цели
@export var stop_distance: float = 25 # Расстояние для остановки около случайной точки

@onready var fly: Fly = character.get_node_or_null("Fly")
var random_point: Vector2 = Vector2.ZERO
var last_target_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	if not fly:
		push_error("Компонент 'Fly' не найден на персонаже!")
	target = character.get_parent().get_node("SpaceMarine")
	last_target_position = get_target_position()
	_update_random_point()

func _process(_delta: float) -> void:
	if not fly or not target or not target_exists():
		return
	
	# Проверяем, переместилась ли цель на расстояние больше follow_radius_area
	var target_position = get_target_position()
	if target_position.distance_to(last_target_position) > follow_radius_area:
		last_target_position = target_position
		_update_random_point()
	
	# Проверяем, находится ли персонаж в области цели
	if character.global_position.distance_to(target_position) <= follow_radius_area:
		# Используем Fly для мгновенной остановки персонажа
		fly.update_velocity(Vector2.ZERO)
		fly.move(_delta)  # Применяем мгновенное обнуление скорости
		return
	
	# Двигаемся к случайной точке
	var direction_to_target = random_point - character.global_position
	if direction_to_target.length() <= stop_distance:
		_update_random_point()
	
	fly.update_velocity(direction_to_target.normalized())
	fly.move(_delta)

func get_target_position() -> Vector2:
	if target and target is Node2D:
		return target.global_position
	return character.global_position

func set_target(new_target: Node2D):
	target = new_target
	

func _update_random_point() -> void:
	# Вычисляем случайную точку в радиусе вокруг цели
	var target_position = get_target_position()
	random_point = target_position + Vector2(
		randf_range(-follow_radius_area, follow_radius_area),
		randf_range(-follow_radius_area, follow_radius_area / 2)
	)

func target_exists() -> bool:
	return target != null
