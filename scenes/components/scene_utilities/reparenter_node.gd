extends Node
class_name ReparenterNode

@export var targets: Array[Node]
@export var target_groups: Array[String]
@export var trigger_reparent: bool = false
@export var trigger_unreparent: bool = false
@export var new_parent: Node

var reparented_nodes: Dictionary[Node, Node]


func _process(delta: float) -> void:
	if trigger_reparent:
		trigger_reparent = false
		_reparent()
	
	if trigger_unreparent:
		trigger_unreparent = false
		_unreparent()

func _reparent():
	var nodes_to_reparent: Array[Node] = []
	
	nodes_to_reparent += targets
	for group: String in target_groups:
		nodes_to_reparent += get_tree().get_nodes_in_group(group)
		
	for node: Node in nodes_to_reparent:
		if node.get_parent() == new_parent:
			continue
		reparented_nodes[node] = node.get_parent()
		node.reparent(new_parent)
	

func _unreparent():
	for node: Node in reparented_nodes.keys():
		node.reparent(reparented_nodes[node])
		reparented_nodes.erase(node)
	
