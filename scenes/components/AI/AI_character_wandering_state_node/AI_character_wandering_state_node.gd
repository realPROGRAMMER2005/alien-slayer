extends StateNode

var timer_resource: TimerResource
var change_direction_timer_resource: TimerResource
@export var change_direction_max_time_seconds: float = 6
@export var change_direction_min_time_seconds: float = 4
@export var max_time_seconds: float = 20.0
@export var min_time_seconds: float = 12.0
@export var idle_state_node: StateNode
@export var radius: float = 200


func _process(delta: float) -> void:
	super._process(delta)
	
	if not idle_state_node and finite_state_machine_node:
		idle_state_node = finite_state_machine_node.get_node("AICharacterIdleStateNode")


func _enter_state():
	timer_resource = TimerResource.new()
	timer_resource.time = randf_range(min_time_seconds, max_time_seconds)
	timer_resource.start()
	change_direction_timer_resource = TimerResource.new()
	change_direction_timer_resource.time = randf_range(change_direction_min_time_seconds, change_direction_min_time_seconds)
	wander()

func _process_state(delta: float):
	timer_resource.process(delta)
	change_direction_timer_resource.process(delta)
	
	if change_direction_timer_resource.is_out:
		wander()
		
	if timer_resource.is_out:
		finite_state_machine_node.change_state(idle_state_node)
	
	
func _exit_state():
	timer_resource = null

func wander():

	if finite_state_machine_node:
		
		var point = GeometryUtilities.get_random_position_around(finite_state_machine_node.owner_node.global_position, radius)
		var aiming_manager_node: AimingManagerNode = finite_state_machine_node.aiming_manager_node
		finite_state_machine_node.movement_node.move_to_point(point)
		change_direction_timer_resource.reset()
		change_direction_timer_resource.start()
		
		if aiming_manager_node:
			aiming_manager_node.current_aiming_mode = aiming_manager_node.AimingModes.ACCORDING_MOVEMENT_VELOCITY_ALL_DIRECTIONS
			aiming_manager_node.aim_to_point = point
			aiming_manager_node.trigger_aiming = true
		
		
		
		
		
