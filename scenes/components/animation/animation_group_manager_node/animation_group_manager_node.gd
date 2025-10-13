extends Node
class_name AnimationGroupManager


@export var target_nodes: Array[Node] = []
@export var target_groups: Array[String] = []
@export var trigger_animation: bool = false
@export var animation_name: String = ""
@export var speed_scale: float = 1

func _process(delta: float) -> void:
	if trigger_animation:
		trigger_animation = false
		play_animation()

func play_animation():
	if not animation_name:
		return
	
	var nodes: Array = []
	

	
	nodes += target_nodes
	for group_name: String in target_groups:
		nodes += get_tree().get_nodes_in_group(group_name)
	
	for node: Node in nodes:
		var animation_manager_node = node.get_node_or_null("AnimationManagerNode") as AnimationManagerNode
		animation_manager_node.play_animation(animation_name, speed_scale)
		
