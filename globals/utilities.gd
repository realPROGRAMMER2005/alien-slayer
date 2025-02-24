extends Node
var level: Level

func _ready() -> void:
	init_level()

func init_level():
	var game_node = get_tree().root.get_node("Game")
	level = Utilities.find_node_by_class_name(game_node, Level)
	
func get_level():
	return level
	
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


func get_component(component_owner_node: Node, component_class_name) -> Node:
	var founded_nodes_with_class_name = find_nodes_by_class_name(component_owner_node, component_class_name)
	if len(founded_nodes_with_class_name) > 0:
		return founded_nodes_with_class_name[0]
	return null
		
func find_node_by_class_name(root: Node, node_class_name) -> Node:
	var founded_nodes_with_class_name = find_nodes_by_class_name(root, node_class_name)
	if len(founded_nodes_with_class_name) > 0:
		return founded_nodes_with_class_name[0]
	return null
