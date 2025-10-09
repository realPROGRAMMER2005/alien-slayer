extends InteractableNode


@export var location_generator_node: LocationGeneratorNode



func _process(delta: float) -> void:
	if not location_generator_node:
		var criteria = NodeFinder.SearchCriteria.new()
		criteria.node_type = "LocationGeneratorNode"
		location_generator_node = NodeFinder.find_nodes(get_parent(), criteria, NodeFinder.SearchDirection.UP_WITH_SIBLINGS, true).get(0)
	
	
		
func interact(interactor):
	super.interact(interactor)
	
	if location_generator_node:
		location_generator_node.clear()
		location_generator_node.generate()
		
