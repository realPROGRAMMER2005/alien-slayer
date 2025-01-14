extends Node2D
class_name ConnectionPoint

@export_enum("Left", "Right", "Top", "Bottom") var type: String
@export var allowed_room_types: Array[String]
var has_used: bool = false


	
