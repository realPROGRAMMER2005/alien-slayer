extends Area2D
class_name RoomArea

func get_global_bounds():
	var collision_shape: CollisionShape2D = $CollisionShape2D
	if collision_shape and collision_shape.shape is RectangleShape2D:
		var rect_shape: RectangleShape2D = collision_shape.shape
		var position: Vector2 = collision_shape.global_position
		var size: Vector2 = rect_shape.size
		return Rect2(position - size / 2, size)
