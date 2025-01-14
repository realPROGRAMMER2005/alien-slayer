extends Item
class_name Weapon

@export var attack_speed: float = 0.4
var is_ready_to_attack: bool = false
var attack_speed_current_cooldown: float


func _init() -> void:
	is_stackable = false

func _ready() -> void:
	attack_speed_current_cooldown = attack_speed

func _process(delta: float) -> void:
	attack_speed_current_cooldown -= delta
	
	
	
func use():
	if attack_speed_current_cooldown <= 0:
		attack()
		attack_speed_current_cooldown = attack_speed
		
func attack():
	pass
