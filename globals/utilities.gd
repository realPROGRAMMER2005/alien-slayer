extends Node
class_name Utitlities

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


func find_nodes_by_class_name(root: Node, node_class_name) -> Array:
	var result: Array = []

	# Проверяем, является ли узел экземпляром указанного класса или его потомка
	if is_instance_of(root, node_class_name):
		result.append(root)

	# Рекурсивно проверяем всех детей
	for child in root.get_children():
		result.append_array(find_nodes_by_class_name(child, node_class_name))

	return result
	
	
func find_owner_by_class(child_node: Node, node_class_name) -> Node:
	var current_node = child_node

	# Идем вверх по иерархии, пока не достигнем корня сцены
	while current_node != null:
		# Проверяем, является ли текущий узел экземпляром указанного класса или его потомка
		if is_instance_of(current_node, node_class_name):
			return current_node  # Возвращаем найденный узел

		# Переходим к родительскому узлу
		current_node = current_node.get_parent()

	# Если ничего не найдено, возвращаем null
	return null
