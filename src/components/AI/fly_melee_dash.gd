# FlyMeleeDash
"""Компонент для выполнения рывка к цели при условии, что путь свободен."""
extends Node2D
class_name FlyMeleeDash

@export var character: Character

@export var target: Node2D
@export var dash_speed: float = 600.0  # Максимальная скорость рывка
@export var dash_acceleration: float = 20.0  # Ускорение рывка
@export var raycast_node: RayCast2D
@export var stop_distance: float = 50.0  # Остановка около цели

var has_perform_melee_dash: bool = false  # Флаг для выполнения рывка

@export var fly: Fly
var dash_direction: Vector2 = Vector2.ZERO  # Направление рывка

func _ready() -> void:
	if not fly:
		push_error("Компонент 'Fly' не найден на персонаже!")
	if not raycast_node:
		push_error("RayCast2D для проверки препятствий не настроен!")

func _process(_delta: float) -> void:
	if not fly or not target or not target_exists():
		return

	if has_perform_melee_dash:
		_perform_dash(_delta)
	else:
		_reset_velocity()

func _perform_dash(_delta: float) -> void:
	# Проверяем путь до цели
	if not _can_dash_to_target():
		has_perform_melee_dash = false
		return
	
	# Вычисляем направление к цели
	var target_position = get_target_position()
	dash_direction = (target_position - character.global_position).normalized()

	# Проверяем, достаточно ли близко к цели
	if character.global_position.distance_to(target_position) <= stop_distance:
		has_perform_melee_dash = false
		_reset_velocity()
		return
	
	# Плавное увеличение скорости в сторону цели
	fly.update_velocity(dash_direction * dash_speed)
	fly.move(_delta)

func _reset_velocity() -> void:
	# Сбрасываем скорость, если рывок не выполняется
	fly.update_velocity(Vector2.ZERO)

func _can_dash_to_target() -> bool:
	# Настраиваем RayCast2D для проверки пути до цели
	if not raycast_node:
		return false
	
	raycast_node.cast_to = target.global_position - raycast_node.global_position
	raycast_node.force_raycast_update()

	return not raycast_node.is_colliding()

func get_target_position() -> Vector2:
	if target and target is Node2D:
		return target.global_position
	return character.global_position

func target_exists() -> bool:
	return target != null
