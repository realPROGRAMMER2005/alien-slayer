extends Area2D
class_name CharacterDetectionArea

var is_searching_for_enemy = true


@export var faction_component: Faction
@export var body: CharacterBody2D
@export var follow_component: FlyFollow

		

func _on_character_entered(other_character: Node2D) -> void:
	if other_character != body:
		var other_character_faction_component: Faction = Utilities.find_node_by_class_name(other_character, Faction)
		if is_searching_for_enemy:
			if other_character_faction_component.current_faction in faction_component.hostile_factions:
				is_searching_for_enemy = false
				follow_component.target = other_character
				print(other_character)
