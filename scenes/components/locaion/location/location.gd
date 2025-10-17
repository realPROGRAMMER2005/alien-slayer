extends Node2D
class_name Location


func _ready() -> void:
	LocationManager.current_location = self
