extends Node

static func safe_connect(source: Object, signal_name: String, target: Object, method: String, flags: int = 0) -> Error:
	if not source or not target:
		return ERR_INVALID_PARAMETER
	
	if not source.has_signal(signal_name):
		return ERR_INVALID_PARAMETER
	
	if not target.has_method(method):
		return ERR_INVALID_PARAMETER
	
	# Проверка, подключен ли сигнал
	var callable = Callable(target, method)
	if source.is_connected(signal_name, callable):
		return ERR_ALREADY_IN_USE
	
	return source.connect(signal_name, callable, flags)

static func safe_disconnect(source: Object, signal_name: String, target: Object, method: String) -> Error:
	if not source or not target:
		return ERR_INVALID_PARAMETER
	
	if not source.has_signal(signal_name):
		return ERR_INVALID_PARAMETER
	
	if not target.has_method(method):
		return ERR_INVALID_PARAMETER
	
	var callable = Callable(target, method)
	if not source.is_connected(signal_name, callable):
		return ERR_UNAVAILABLE
	
	source.disconnect(signal_name, callable)
	return OK
