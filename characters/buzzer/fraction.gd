extends Node
class_name Fraction

@export var friendly_fractions: Array[FractionList.FractionList]
@export var neutral_fractions: Array[FractionList.FractionList]
@export var enemy_fractions: Array[FractionList.FractionList]
@export var self_fraction: FractionList.FractionList

func _ready() -> void:
	if self_fraction not in friendly_fractions:
		friendly_fractions.append(self_fraction)
