extends StateNode

@export var min_time_seconds: float = 2.0
@export var max_time_seconds: float = 10.0
@export var wandering_state_node: StateNode
var timer_resource: TimerResource



func _process(delta: float) -> void:
	super._process(delta)
	
	
	if not wandering_state_node and finite_state_machine_node:
		wandering_state_node = finite_state_machine_node.get_node("AICharacterWanderingStateNode")

# Вход в состояние
func _enter_state():
	timer_resource = TimerResource.new()
	timer_resource.time = randf_range(min_time_seconds, max_time_seconds)
	timer_resource.start()
	
	
	

# Выход из состояния
func _exit_state():
	
	timer_resource = null

# Обработка состояния каждый кадр
func _process_state(delta: float):
	timer_resource.process(delta)
	
	if finite_state_machine_node:

		finite_state_machine_node.movement_node.current_movement_type = finite_state_machine_node.movement_node.original_movement_type
		finite_state_machine_node.movement_node.set_move(Vector2.ZERO)
		
	if timer_resource.is_out and finite_state_machine_node:
		finite_state_machine_node.change_state(wandering_state_node)
		
		
