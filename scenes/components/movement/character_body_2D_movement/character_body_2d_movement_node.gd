extends Node
class_name CharacterBody2DMovementNode

@export var movement_type: MovementSystem.CharacterBody2DMovementTypes
@export var max_speed: float = 300.0
@export var jump_force: float = 400.0
@export var acceleration: float = 1000.0
@export var deceleration: float = 1000.0
@export var insta_max_speed: bool = false
@export var insta_stopping: bool = false
@export var falling_gravity_scale: float = 1.0
@export var rising_gravity_scale: float = 1.0

var _move: Vector2 = Vector2.ZERO
@export var character_body_2D: CharacterBody2D

func _process(delta: float) -> void:
	if not character_body_2D:
		character_body_2D = get_parent() as CharacterBody2D
	


func _physics_process(delta: float) -> void:
	if not character_body_2D:
		return
	
	match movement_type:
		MovementSystem.CharacterBody2DMovementTypes.WALKING:
			_apply_walking_movement(delta)
		MovementSystem.CharacterBody2DMovementTypes.FLYING:
			_apply_flying_movement(delta)
	
	character_body_2D.move_and_slide()

func set_move(move: Vector2) -> void:
	_move = move

func jump() -> void:
	if movement_type == MovementSystem.CharacterBody2DMovementTypes.WALKING and character_body_2D.is_on_floor():
		character_body_2D.velocity.y = -jump_force

func _apply_walking_movement(delta: float) -> void:
	var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
	var velocity: Vector2 = character_body_2D.velocity
	
	# Apply gravity based on vertical velocity
	if velocity.y > 0:
		velocity.y += gravity * falling_gravity_scale * delta
	else:
		velocity.y += gravity * rising_gravity_scale * delta
	
	# Horizontal movement
	if _move.x != 0:
		if insta_max_speed:
			velocity.x = _move.x * max_speed
		else:
			velocity.x = move_toward(velocity.x, _move.x * max_speed, acceleration * delta)
	else:
		if insta_stopping:
			velocity.x = 0
		else:
			velocity.x = move_toward(velocity.x, 0, deceleration * delta)
	
	character_body_2D.velocity = velocity

func _apply_flying_movement(delta: float) -> void:
	var velocity: Vector2 = character_body_2D.velocity
	
	# Horizontal movement
	if _move.x != 0:
		if insta_max_speed:
			velocity.x = _move.x * max_speed
		else:
			velocity.x = move_toward(velocity.x, _move.x * max_speed, acceleration * delta)
	else:
		if insta_stopping:
			velocity.x = 0
		else:
			velocity.x = move_toward(velocity.x, 0, deceleration * delta)
	
	# Vertical movement
	if _move.y != 0:
		if insta_max_speed:
			velocity.y = _move.y * max_speed
		else:
			velocity.y = move_toward(velocity.y, _move.y * max_speed, acceleration * delta)
	else:
		if insta_stopping:
			velocity.y = 0
		else:
			velocity.y = move_toward(velocity.y, 0, deceleration * delta)
	
	character_body_2D.velocity = velocity
