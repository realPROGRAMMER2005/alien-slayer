extends Node2D
class_name LevelSegment

var next_segment_point: NextSegmentPoint


func init_next_segment_position_point():
	next_segment_point = Utilities.find_node_by_class_name(self, NextSegmentPoint)

func _ready() -> void:
	init_next_segment_position_point()
