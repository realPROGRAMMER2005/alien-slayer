extends Node



@export var saved_nodes: Dictionary[String, Array] = {}

func save_node(node: Node, key: String):
	node.reparent(self)
	
	if saved_nodes.has(key):
		saved_nodes[key].append(node)
	

func load_nodes(key: String) -> Array[Node]:
	var nodes = saved_nodes[key]
	saved_nodes.erase(key)
	
	for node in nodes:
		SpawnUtilities.spawn_node_reparent(node, LocationManager.current_location)
		
	return nodes
	
	
