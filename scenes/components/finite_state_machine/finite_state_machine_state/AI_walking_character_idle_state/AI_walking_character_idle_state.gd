extends FiniteStateMachineState

@export var min_time_seconds: float = 2.0
@export var max_time_seconds: float = 10.0
@export var patrolling_state: FiniteStateMachineState
var timer_resource: TimerResource


func _process(delta: float) -> void:
	super._process(delta)

# Вход в состояние
func _enter_state():
	timer_resource = TimerResource.new()
	timer_resource.time = randf_range(min_time_seconds, max_time_seconds)
	timer_resource.start()

# Выход из состояния
func _exit_state():
	pass

# Обработка состояния каждый кадр
func _process_state(delta: float):
	timer_resource.process(delta)
	if timer_resource.is_out:
		finite_state_machine.change_state(patrolling_state)
