extends Node
class_name FiniteStateMachineState


@export var finite_state_machine: FiniteStateMachine

func _process(delta: float) -> void:
	if not finite_state_machine:
		finite_state_machine = get_parent()

# Вход в состояние
func _enter_state():
	pass

# Выход из состояния
func _exit_state():
	pass

# Обработка состояния каждый кадр
func _process_state(delta: float):
	pass
