extends Node
class_name AimingManagerNode

@export var aim_to_point: Vector2 = Vector2.ZERO
@export var trigger_aiming: bool = false

enum AimingModes {ACCORDING_MOVEMENT_VELOCITY_ALL_DIRECTIONS, ACCORDING_VELOCITY_HORIZONAL, TO_POINT_POSITION, ANGLE}

@export var current_aiming_mode := AimingModes.TO_POINT_POSITION
@export var movement_node: MovementNode
@export var trigger_update_aiming_skeleton_part_nodes: bool = true
@export var aiming_skeleton_part_nodes: Array[Node] = []
var aiming_angle_degrees: float = 0.0  # Исправлена опечатка: aiming_anlge_degress -> aiming_angle_degrees

func _process(delta: float) -> void:
	if not movement_node:
		
		movement_node = get_parent().find_child("*MovementNode*", false, false)
	
	if trigger_update_aiming_skeleton_part_nodes:
		trigger_update_aiming_skeleton_part_nodes = false
		_update_aiming_skeleton_parts()
	
	if trigger_aiming: 
		_update_aiming()
		trigger_aiming = false

func _update_aiming_skeleton_parts():
	aiming_skeleton_part_nodes = get_parent().find_children("*", "AimingSkeletonPartNode", true, false)

func _update_aiming():
	# Новая логика: в зависимости от режима рассчитываем цель или угол для каждого AimingSkeletonPartNode
	for node: AimingSkeletonPartNode in aiming_skeleton_part_nodes:
		match current_aiming_mode:
			
			AimingModes.ACCORDING_MOVEMENT_VELOCITY_ALL_DIRECTIONS:
				# Режим 1: направление полной скорости
				if movement_node and movement_node.owner_node_velocity != Vector2.ZERO:
					# Рассчитываем "виртуальную" точку в направлении скорости (на расстоянии 100 для стабильности)
					var virtual_aim_point = node.owner_node.global_position + movement_node.owner_node_velocity.normalized() * 100
					node.update_aiming(virtual_aim_point)
				# Если скорость нулевая, не меняем угол
			AimingModes.ACCORDING_VELOCITY_HORIZONAL:
				# Режим 2: только горизонтальная скорость
				if movement_node and movement_node.owner_node_velocity.x != 0:
					var horizontal_direction = sign(movement_node.owner_node_velocity.x)  # 1 вправо, -1 влево
					var virtual_aim_point = node.owner_node.global_position + Vector2(horizontal_direction * 100, 0)
					node.update_aiming(virtual_aim_point)
				# Если горизонтальная скорость нулевая, не меняем угол
			AimingModes.TO_POINT_POSITION:
				# Уже реализованный режим: на точку
				node.update_aiming(aim_to_point)
			AimingModes.ANGLE:
				# Режим 3: фиксированный угол
				node.set_fixed_angle(aiming_angle_degrees)  # Новый метод для прямой установки угла
