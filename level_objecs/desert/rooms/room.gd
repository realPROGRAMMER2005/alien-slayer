extends Node2D
class_name Room

var connection_points: Array[ConnectionPoint]
@onready var tilemap_layers_node = get_node("TileMapLayers")
@export var type: String
var rect_width: float
var rect_height: float
var rect_x: float
var rect_y: float
var size: Vector2
var rect: Rect2
@export var value: float = 1


func _ready() -> void:
	update_size()
	

	

func get_connection_points() -> Array[ConnectionPoint]:
	connection_points = []
	for child in get_node("ConnectionPoints").get_children():
		connection_points.append(child)
	return connection_points

func get_connection_point_by_type(connection_point_type: String) -> ConnectionPoint:
	for connection_point in get_connection_points():
		if connection_point.type == connection_point_type:
			return connection_point
	return null

func update_size():
	var widths: Array[float] = []
	var heights: Array[float] = []
	var xs: Array[float] = []
	var ys: Array[float] = []
	
	for tilemap_layer: TileMapLayer in tilemap_layers_node.get_children():
		xs.append(tilemap_layer.get_used_rect().position.x * tilemap_layer.tile_set.tile_size.x)
		ys.append(tilemap_layer.get_used_rect().position.y * tilemap_layer.tile_set.tile_size.y)
		widths.append(tilemap_layer.get_used_rect().size.x * tilemap_layer.tile_set.tile_size.x)
		heights.append(tilemap_layer.get_used_rect().size.y * tilemap_layer.tile_set.tile_size.y)
	rect_width = widths.max()
	rect_height = heights.max()
	rect_x = xs.min()
	rect_y = ys.min()
	size = Vector2(rect_width, rect_height)
	rect = Rect2(rect_x, rect_y, rect_width, rect_height)
	
func get_size():
	return size

	
		
