extends Resource
class_name TimerResource


@export var time: float = 5
var timer: float
var is_out: bool = false
var has_started: bool = false

func start():
	has_started = true
	timer = time

	
	
func process(delta: float):
	if has_started:
		timer -= delta
		
		
		if timer <= 0:
			is_out = true

func reset():
	timer = time
	is_out = false
