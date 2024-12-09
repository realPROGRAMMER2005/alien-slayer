# Move

"""Компонент, который необходим, чтобы реализовать
движение объекта по горизонтали и гравитацию."""

extends Node
@onready var character: CharacterBody2D = get_parent()


func _process(_delta: float) -> void:
	if character:
		character.move_and_slide()
	
