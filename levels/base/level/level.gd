extends Node2D
class_name Level

@export var start_segment_scene: PackedScene
@export var end_segment_scene: PackedScene
var next_segment_position: Vector2 = Vector2(0, 0)
@export var segment_scenes: Array[PackedScene]
@export var level_length_in_segments: int = 120
@export var background_scene: PackedScene

func add_background():
	var background_instance = background_scene.instantiate()
	add_child(background_instance)


func generate_segment(segment_scene: PackedScene) -> void:
	var segment_instance: LevelSegment = segment_scene.instantiate()
	add_child(segment_instance)
	segment_instance.global_position = next_segment_position
	next_segment_position = segment_instance.next_segment_point.global_position

func generate():
	generate_segment(start_segment_scene)
	for i in range(level_length_in_segments):
		generate_segment(segment_scenes.pick_random())
	generate_segment(end_segment_scene)

	
func _ready() -> void:
	generate()
	add_background()
	
