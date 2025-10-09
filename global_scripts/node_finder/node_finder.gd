extends Node

# Перечисление для направления поиска
enum SearchDirection {
	DOWN,         # Поиск вниз по дереву (дети, дети детей и т.д.)
	UP,           # Поиск вверх по дереву (родители)
	UP_WITH_SIBLINGS,  # Поиск вверх с учетом "дядей" (родители и их братья)
	ALL_DIRECTIONS    # Поиск во все стороны (вниз + вверх с дядями)
}

# Класс для критериев поиска
class SearchCriteria:
	var node_type: String = ""  # Тип узла в виде строки (например, "Node2D", "Sprite2D")
	var node_name: String = ""  # Имя узла
	var group: String = ""  # Группа узла
	var property: String = ""  # Имя свойства
	var property_value = null  # Значение свойства (null означает любое значение)
	var signal_name: String = ""  # Имя сигнала
	var method_name: String = ""  # Имя метода
	
	# Проверка, соответствует ли узел критериям
	func matches(node: Node) -> bool:
		var is_match = true
		
		# Проверка типа узла с полной иерархией наследования (для пользовательских классов через скрипт)
		if node_type != "":
			var is_type_match = is_class_or_descendant(node, node_type)
			if not is_type_match:
				is_match = false
		
		# Проверка имени узла
		if node_name != "" and node.name != node_name:
			is_match = false
		
		# Проверка группы
		if group != "" and not node.is_in_group(group):
			is_match = false
		
		# Проверка свойства
		if property != "":
			if not node.has_node_path(property) and not node.has_meta(property):
				is_match = false
			else:
				if property_value != null:
					var value = node.get(property) if node.has_node_path(property) else node.get_meta(property)
					is_match = is_match and value == property_value
		
		# Проверка сигнала
		if signal_name != "" and not node.has_signal(signal_name):
			is_match = false
		
		# Проверка метода
		if method_name != "" and not node.has_method(method_name):
			is_match = false
			
		return is_match
	
	# Рекурсивная проверка, является ли класс текущим или наследником target_class (через скрипт)
	func is_class_or_descendant(node: Node, target_class: String) -> bool:
		var script = node.get_script()
		if script == null:
			return false
		return _check_script_hierarchy(script, target_class)
	
	# Внутренняя рекурсивная функция для проверки иерархии скрипта
	func _check_script_hierarchy(script: Script, target_class: String, depth: int = 0) -> bool:
		const MAX_DEPTH = 20
		if depth > MAX_DEPTH:
			return false
		
		var node_class_name = script.get_global_name()
		if node_class_name == target_class:
			return true
		
		var base_script = script.get_base_script()
		if base_script == null:
			return false
		return _check_script_hierarchy(base_script, target_class, depth + 1)

# Основная функция поиска
static func find_nodes(
	root: Node,
	criterion: SearchCriteria,
	direction: SearchDirection = SearchDirection.DOWN,
	find_all: bool = false
) -> Array[Node]:
	var results: Array[Node] = []
	var visited: Array[Node] = []  # Множество для отслеживания посещенных узлов
	
	# Вспомогательная функция для проверки критерия
	var matches_criteria = func(node: Node) -> bool:
		return criterion.matches(node)
	
	# Проверка самого корневого узла
	if not visited.has(root):
		if matches_criteria.call(root):
			results.append(root)
			if not find_all:
				return results
	
	# Выбор направления поиска
	if direction == SearchDirection.DOWN:
		_search_down(root, matches_criteria, results, visited, find_all)
	elif direction == SearchDirection.UP:
		_search_up(root, matches_criteria, results, visited, find_all)
	elif direction == SearchDirection.UP_WITH_SIBLINGS:
		_search_up_with_siblings(root, matches_criteria, results, visited, find_all)
	elif direction == SearchDirection.ALL_DIRECTIONS:
		_search_down(root, matches_criteria, results, visited, find_all)
		_search_up_with_siblings(root, matches_criteria, results, visited, find_all)
	
	return results

# Вспомогательная функция для поиска вниз
static func _search_down(
	node: Node,
	matches_criteria: Callable,
	results: Array[Node],
	visited: Array[Node],
	find_all: bool
):
	if visited.has(node):
		return
	visited.append(node)
	
	for child in node.get_children():
		if not visited.has(child):
			if matches_criteria.call(child):
				results.append(child)
				if not find_all:
					return
			_search_down(child, matches_criteria, results, visited, find_all)

# Вспомогательная функция для поиска вверх
static func _search_up(
	node: Node,
	matches_criteria: Callable,
	results: Array[Node],
	visited: Array[Node],
	find_all: bool
):
	var parent = node.get_parent()
	if parent == null or visited.has(parent):
		return
	visited.append(parent)
	
	if matches_criteria.call(parent):
		results.append(parent)
		if not find_all:
			return
	
	_search_up(parent, matches_criteria, results, visited, find_all)

# Вспомогательная функция для поиска вверх с "дядями"
static func _search_up_with_siblings(
	node: Node,
	matches_criteria: Callable,
	results: Array[Node],
	visited: Array[Node],
	find_all: bool
):
	var parent = node.get_parent()
	if parent == null or visited.has(parent):
		return
	visited.append(parent)
	
	# Проверяем родителя
	if matches_criteria.call(parent):
		results.append(parent)
		if not find_all:
			return
	
	# Проверяем братьев родителя (дядей)
	var grandparent = parent.get_parent()
	if grandparent != null and not visited.has(grandparent):
		visited.append(grandparent)
		for sibling in grandparent.get_children():
			if sibling != parent and not visited.has(sibling):
				if matches_criteria.call(sibling):
					results.append(sibling)
					if not find_all:
						return
	
	# Продолжаем поиск вверх
	_search_up_with_siblings(parent, matches_criteria, results, visited, find_all)
