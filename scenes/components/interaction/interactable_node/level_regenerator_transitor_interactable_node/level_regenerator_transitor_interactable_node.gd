extends InteractableNode


@export var location_generator_node: LocationGeneratorNode


func interact(interactor):
	location_generator_node.clear()
	location_generator_node.generate()
