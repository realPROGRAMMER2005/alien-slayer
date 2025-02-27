extends Node
class_name FlyFollow

@export var fly_component: Fly  # Компонент Fly для управления движением
@export var pathfinder: Pathfinder  # Компонент Pathfinder для поиска пути
@export var target: Node2D  # Цель, за которой нужно следовать
@export var arrival_threshold: float = 10.0  # Расстояние, на котором считается, что цель достигнута

func _process(delta):
	if not target:
		return  # Если цель не задана, ничего не делаем

	# Устанавливаем цель для Pathfinder
	pathfinder.set_target(target.global_position)

	# Получаем направление движения
	var direction = pathfinder.get_movement_direction()

	# Двигаемся в направлении
	fly_component.fly(direction)

	# Если достигли цели, останавливаемся
	if fly_component.character.global_position.distance_to(target.global_position) < arrival_threshold:
		fly_component.fly(Vector2.ZERO)
