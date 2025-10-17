extends Node

@export var spawn_point_node_2D: Node2D
@export var packed_scene: PackedScene
@export var parent: Node
@export var location_as_parent: bool = false


@export var properties: Dictionary[String, Variant]


func spawn():
	var instance = packed_scene.instantiate()
	
	var parent_: Node
	if location_as_parent:
		parent_ = get_tree().current_scene.find_child("*Location*", true, false)
	else: 
		parent_ = parent	
	
	if spawn_point_node_2D:
		properties["global_position"] = spawn_point_node_2D.global_position
		
	SpawnUtilities.spawn_packed_scene(packed_scene, parent_, properties)
	
