extends Node
class_name Fraction

@export var friendly_fractions: Array[String] = []
@export var neutral_fractions: Array[String] = []
@export var enemy_fractions: Array[String] = []

func get_friendly_fractions() -> Array[String]:
	return friendly_fractions

func get_neutral_fractions() -> Array[String]:
	return neutral_fractions

func get_enemy_fractions() -> Array[String]:
	return enemy_fractions
