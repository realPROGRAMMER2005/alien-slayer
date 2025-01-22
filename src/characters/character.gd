extends CharacterBody2D
class_name Character

func _process(_delta: float) -> void:
	move_and_slide()


func _on_hitbox_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
