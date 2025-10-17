extends Node





func spawn_packed_scene(packed_scene: PackedScene, parent_node: Node, properties: Dictionary[String, Variant] = {}):
	var instance: Node = packed_scene.instantiate()
	
	for property_name: String in properties:
		instance.set(property_name, properties[property_name])
	
	parent_node.add_child(instance, true)
	
	return instance

func spawn_node_reparent(node: Node, new_parent_node: Node, properties: Dictionary[String, Variant] = {}):
	node.reparent(new_parent_node)
	
	for property_name: String in properties:
		node.set(property_name, properties[property_name])
	
	new_parent_node.add_child(node, true)
	
	return node
	
	

func spawn_node_duplicate(node: Node2D, new_parent_node: Node, properties: Dictionary[String, Variant] = {}):
	var instance = node.duplicate()
	for property_name: String in properties:
		instance.set(property_name, properties[property_name])
	
	new_parent_node.add_child(instance, true)
	
	return instance
