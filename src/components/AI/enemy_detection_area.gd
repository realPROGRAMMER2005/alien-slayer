extends Area2D
@export var character: Character
@export var fraction: Fraction
@export var follow: Node2D

var enemy_fractions: Array[String]
var has_search_for_enemy = false
var has_found_enemy = false

func _ready() -> void:
	enemy_fractions = fraction.get_enemy_fractions()
	
func start_search_for_enemy():
	has_search_for_enemy = false


func _process(_delta: float) -> void:
	if has_search_for_enemy:
		var body_enemy_fractions: Array[String]
		if has_overlapping_bodies():
			for body in get_overlapping_bodies():
				if body.has_node("Fraction"):
					body_enemy_fractions = body.get_node("Fraction").get_enemy_fractions()
				for enemy_fraction: String in body_enemy_fractions:
					if enemy_fraction in enemy_fractions:
						has_search_for_enemy = false
						has_found_enemy = true
						break
				if has_found_enemy:
					follow.set_target(body)
					break
					

		

			
			

				
	
