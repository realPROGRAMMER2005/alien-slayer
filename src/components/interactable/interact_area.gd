extends Area2D
class_name InteractArea

func _ready() -> void:
	set_collision_layer_value(5, true)
	set_collision_mask_value(5, true)
	
