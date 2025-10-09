extends Node





func spawn_packed_scene_node_2D(packed_scene: PackedScene, position: Vector2, parent_node: Node):
	var instance: Node2D = packed_scene.instantiate()
	instance.global_position = position
	parent_node.add_child(instance, true)
	
	return instance
