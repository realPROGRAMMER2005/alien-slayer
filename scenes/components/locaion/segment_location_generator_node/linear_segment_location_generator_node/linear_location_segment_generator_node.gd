extends LocationGeneratorNode
class_name LinearSegmentLocationGeneratorNode


@export var start_segment_scenes: Array[PackedScene] = []
@export var default_segment_scenes: Array[PackedScene] = []
@export var end_segment_scenes: Array[PackedScene] = []
@export var next_segment_position: Vector2 = Vector2(0, 0)
@export var location_length_segments: int = 15
@export var location: Location
@export var trigger_generate: bool = true
var _segments: Array[Node2D] = []

func generate():
	var segment_scene: PackedScene
	var segment_instance: Node2D
	
	segment_scene = start_segment_scenes.pick_random()
	segment_instance = generate_segment(segment_scene, next_segment_position)
	next_segment_position = segment_instance.get_node("NextSegmentPoint").global_position
	
	for i in range(location_length_segments):
		segment_scene = default_segment_scenes.pick_random()
		segment_instance = generate_segment(segment_scene, next_segment_position)
		next_segment_position = segment_instance.get_node("NextSegmentPoint").global_position
	
	segment_scene = end_segment_scenes.pick_random()
	generate_segment(segment_scene, next_segment_position)
	

func _process(delta: float) -> void:
	if not location:
		location = get_parent()
	
	if location and trigger_generate:
		trigger_generate = false
		generate()


func generate_segment(segment_scene: PackedScene, position: Vector2):
	var segment_instance = SpawnUtilities.spawn_packed_scene_node_2D(segment_scene, position, location)
	_segments.append(segment_instance)
	return segment_instance
	

func clear():
	for segment: Node2D in _segments:
		segment.queue_free()
