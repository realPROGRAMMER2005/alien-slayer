extends Node
class_name Attack

var is_attacking: bool = false
var target_to_attack: Node2D
@export var look_at_component: LookAt
@export var muzzle_component: Muzzle
@export var follow_component: FlyFollow

var effective_range: int

func _ready() -> void:
	effective_range = randi_range(50, 80)


func _process(delta: float) -> void:
	if target_to_attack and is_attacking:
		look_at_component.target = target_to_attack
		muzzle_component.global_rotation = look_at_component.get_look_at_angle()
	
	if target_to_attack:
		if owner.global_position.distance_to(target_to_attack.global_position) >= effective_range:
			follow_component.start_following(target_to_attack)
			is_attacking = false
