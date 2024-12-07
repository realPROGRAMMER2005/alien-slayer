# Move

"""Компонент, который необходим, чтобы реализовать
движение объекта по горизонтали и гравитацию."""

extends Node
@export var movable_object: CollisionObject2D


func _process(_delta: float) -> void:
	if movable_object:
		movable_object.move_and_slide()
	
