extends MovementNode
class_name CharacterBody2DMovementNode

@export var max_speed: float = 300.0
@export var jump_force: float = 400.0
@export var acceleration: float = 1000.0
@export var deceleration: float = 1000.0
@export var falling_gravity_scale: float = 1.0
@export var rising_gravity_scale: float = 1.0

var _move: Vector2 = Vector2.ZERO
@export var navigation_agent: NavigationAgent2D
@export var target_position: Vector2
@export var is_moving_to_point: bool = false


func _process(delta: float) -> void:
	
	if not owner_node:
		owner_node = get_parent() as CharacterBody2D
	
	if not navigation_agent:
		navigation_agent = get_parent().get_node("NavigationAgent2D")
	
	if owner_node:
		owner_node_velocity = owner_node.velocity

func _physics_process(delta: float) -> void:
	if not owner_node:
		return
	
	if is_moving_to_point:
		_follow_navigation_path(delta)
	
	match current_movement_type:
		MovementSystem.MovementTypes.WALKING:
			_apply_walking_movement(delta)
		MovementSystem.MovementTypes.FLYING:
			_apply_flying_movement(delta)
	
	owner_node.move_and_slide()

func set_move(move: Vector2) -> void:
	_move = move

func jump() -> void:
	if current_movement_type == MovementSystem.MovementTypes.WALKING and owner_node.is_on_floor():
		owner_node.velocity.y = -jump_force

func _apply_walking_movement(delta: float) -> void:
	var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
	var velocity: Vector2 = owner_node.velocity
	
	# Применение гравитации в зависимости о т вертикальной скорости
	if velocity.y > 0:
		velocity.y += gravity * falling_gravity_scale * delta
	else:
		velocity.y += gravity * rising_gravity_scale * delta
	
	# Горизонтальное движение
	if _move.x != 0:
		velocity.x = move_toward(velocity.x, _move.x * max_speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)
	
	owner_node.velocity = velocity

func _apply_flying_movement(delta: float) -> void:
	var velocity: Vector2 = owner_node.velocity
	
	# Горизонтальное движение
	if _move.x != 0:
		velocity.x = move_toward(velocity.x, _move.x * max_speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)
	
	# Вертикальное движение
	if _move.y != 0:
		velocity.y = move_toward(velocity.y, _move.y * max_speed, acceleration * delta)
	else:
		velocity.y = move_toward(velocity.y, 0, deceleration * delta)
	
	owner_node.velocity = velocity

func move_to_point(target_position: Vector2) -> void:
	
	
	target_position = target_position
	navigation_agent.set_target_position(target_position)
	is_moving_to_point = true

func _follow_navigation_path(delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		is_moving_to_point = false
		_move = Vector2.ZERO
		return
	
	# Получаем следующую точку пути
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var direction: Vector2 = (next_path_position - owner_node.global_position).normalized()
	
	# Устанавливаем направление движения
	_move = direction
	
	# Проверяем, достигли ли мы цели
	if owner_node.global_position.distance_to(target_position) < navigation_agent.target_desired_distance:
		is_moving_to_point = false
		_move = Vector2.ZERO
