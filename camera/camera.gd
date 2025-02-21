extends Camera2D
@export var follow_speed: float = 4
@export var max_distance: Vector2 = Vector2(80, 70)
var new_position: Vector2

@onready var target = get_parent()



func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	new_position = global_position.lerp(get_global_mouse_position(), follow_speed * delta)
	
	
	if target:
		if abs(target.global_position.x - new_position.x) <= max_distance.x:
			global_position.x = new_position.x
		if abs(target.global_position.y - new_position.y) <= max_distance.y:
			global_position.y = new_position.y
		



	
