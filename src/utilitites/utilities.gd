extends Node


func get_level():
	return	get_tree().root.get_node("Game").get_node("Level")
	
func find_nodes_by_name(root: Node, node_name: String) -> Array:
	var result = []
	if root.name == node_name:
		result.append(root)
	for child in root.get_children():
		if child is Node:
			result += find_nodes_by_name(child, node_name)
	return result
