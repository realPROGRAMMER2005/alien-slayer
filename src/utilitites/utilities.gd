extends Node


func get_level():
	return	get_tree().root.get_node("Game").get_node("Level")
	
func find_nodes_by_name(root: Node, name: String) -> Array:
	var result = []
	if root.name == name:
		result.append(root)
	for child in root.get_children():
		if child is Node:
			result += find_nodes_by_name(child, name)
	return result
