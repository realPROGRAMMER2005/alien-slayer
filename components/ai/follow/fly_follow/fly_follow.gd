extends Node
class_name FlyFollow

@export var fly_component: Fly  # Компонент Fly для управления движением
@export var pathfinder: Pathfinder  # Компонент Pathfinder для поиска пути
@export var target: Node2D  # Цель, за которой нужно следовать
@export var arrival_threshold: float = 60  # Расстояние, на котором считается, что цель достигнута
@export var attack_component: Attack  # Компонент атаки
@export var look_at_component: LookAt  # Компонент для поворота к цели

var is_following = false  # Флаг, указывающий, что персонаж следует за целью

func _process(delta):

	
	if not is_following or not target:
		return  # Если не следуем за целью или цель не задана, ничего не делаем

	# Устанавливаем цель для Pathfinder
	pathfinder.set_target(target.global_position)

	# Получаем направление движения
	var direction = pathfinder.get_movement_direction()

	# Двигаемся в направлении
	fly_component.fly(direction)

	# Поворачиваемся к цели
	if look_at_component:
		look_at_component.look_at(target.global_position)

	# Проверяем, достигли ли мы цели
	if fly_component.character.global_position.distance_to(target.global_position) <= attack_component.effective_range:
		# Останавливаем движение
		fly_component.fly(Vector2.ZERO)

		# Переключаемся на атаку
		if attack_component:
			attack_component.target_to_attack = target
			attack_component.is_attacking = true

		# Прекращаем следование
		is_following = false

# Начать следование за целью
func start_following(new_target: Node2D):
	target = new_target
	is_following = true

# Прекратить следование
func stop_following():
	is_following = false
	fly_component.fly(Vector2.ZERO)
