extends InteractableNode

@export var location_generator_node: LocationGeneratorNode





func _process(delta: float) -> void:
	if not location_generator_node:
		var criteria = NodeFinder.SearchCriteria.new()
		criteria.node_type = "LocationGeneratorNode"
		location_generator_node = NodeFinder.find_nodes(get_parent(), criteria, NodeFinder.SearchDirection.UP_WITH_SIBLINGS, true).get(0)

func interact(interactor_node: InteractorNode):
	super.interact(interactor_node)
	
	
	animation_signal.emit("location_regenerate")
	
	
	
	
