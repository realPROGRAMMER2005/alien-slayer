extends Node2D
class_name Level

@export var name_: String = "Level Name"
@export var segment_amount: int = 50
@export var scenes_directory_path: String

var segments: Dictionary
var next_segment_position: Vector2 = Vector2(0, 0)
var border_points: Array

func _ready() -> void:
	generate()

func update_next_segment_position(segment: LevelSegment):
	next_segment_position = segment.next_segment_point.global_position
	

func look_for_border_point(segment: LevelSegment):
	var segment_border_points: Array = Utilities.find_nodes_by_class_name(segment, LevelBorderPoint)
	if len(segment_border_points) > 0:
		border_points += segment_border_points
	
	

func place_segment(segment_scene: PackedScene, segment_position: Vector2):
	var segment_instance: LevelSegment = segment_scene.instantiate()
	add_child(segment_instance)
	segment_instance.global_position = segment_position
	next_segment_position = segment_instance.next_segment_point.global_position
	update_next_segment_position(segment_instance)
	look_for_border_point(segment_instance)
	

func generate():
	segments = Utilities.load_scene_tree(scenes_directory_path)
	
	var start_segment_scene: PackedScene = segments.get("start").pick_random()
	var end_segment_scene: PackedScene = segments.get("start").pick_random()
	var regular_segment_scenes: Array = segments.get("regular")
	
	place_segment(start_segment_scene, next_segment_position)
	
	for i in range(segment_amount):
		place_segment(regular_segment_scenes.pick_random(), next_segment_position)
	
	place_segment(end_segment_scene, next_segment_position)
	print(border_points)
		
