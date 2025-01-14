extends Node2D

@onready var legs = get_node("Legs")
@onready var body = get_node("Legs/Body")
@onready var head = get_node("Head")
@onready var animation_player = get_node("AnimationPlayer")
@onready var arms = get_node("Legs/Body/Arms")
@onready var front_upper_arm = get_node("Legs/Body/Arms/FrontUpperArm")
@onready var front_lower_arm = get_node("Legs/Body/Arms/FrontUpperArm/FrontLowerArm")
@onready var back_upper_arm = get_node("Legs/Body/Arms/BackUpperArm")
@onready var back_lower_arm = get_node("Legs/Body/Arms/BackUpperArm/BackLowerArm")
@onready var current_item_sprite = get_node("Legs/Body/Arms/FrontUpperArm/FrontLowerArm/CurrentItemSprite")

var has_played_to_idle: bool = false
var is_aiming: bool = false
var current_aiming_time: float = 0
var max_aiming_time: float = 3

var current_item = null


@onready var character = get_parent()
@onready var player_controller = get_parent().get_node("PlayerController")
@onready var inventory = get_parent().get_node("Inventory")

var angle: float = 0
var weapon_angle: float = 0

func attach_item_sprite_to_character_sprite(item):
	if item is Item:
		var equipped_item_visuals = item.equipped_scene.instantiate()
		current_item_sprite.add_child(equipped_item_visuals)
		equipped_item_visuals.global_position = current_item_sprite.global_position
		
	
	
func attach_item_sprite_to_item():
	if current_item_sprite.get_child_count() != 0:
		current_item_sprite.get_child(0).queue_free()

func switch_current_item_sprites(new_current_item, previous_item):
	attach_item_sprite_to_item()
	attach_item_sprite_to_character_sprite(new_current_item)
	current_item = new_current_item

func _ready() -> void:
	var character_inventory = character.get_node("Inventory")
	if character_inventory:
		character_inventory.connect("item_used", item_used)
		character_inventory.connect("current_item_switched", switch_current_item_sprites)
		
		
func item_used(item):
	if item is Weapon:
		is_aiming = true


func _process(_delta: float) -> void:
	
		
	
	if player_controller:
		
		
		angle = (rad_to_deg(head.global_position.angle_to_point(get_global_mouse_position())))
		weapon_angle = (rad_to_deg(arms.global_position.angle_to_point(get_global_mouse_position())))
		#print(angle)
		
	angle = round(angle / (360 / 24)) * (360 / 24)
	weapon_angle = round(angle / (360 / 24)) * (360 / 24)
	if ((angle >= 90 and angle <= 180) or (angle <= -90 and angle >= -180)) and character.velocity.x < 0 and not is_aiming:
		body.scale.x = -1
		
	elif angle < 90 and angle >= -90 and character.velocity.x > 0 and not is_aiming:
		body.scale.x = 1
			
	elif ((angle >= 90 and angle <= 180) or (angle <= -90 and angle >= -180)) and is_aiming:
		body.scale.x = -1
		
		arms.rotation = -deg_to_rad(weapon_angle - 180)
		
	
	elif angle < 90 and angle >= -90 and is_aiming:
		body.scale.x = 1
			
		arms.rotation = deg_to_rad(weapon_angle)
			
		
		
			
	
	if angle <= 90 and angle >= -90:
		head.flip_h = false
		head.rotation = deg_to_rad(angle)
	else:
		head.flip_h = true
		head.rotation = deg_to_rad(angle + 180)
	
	if character.velocity.x != 0:
		legs.animation = 'run'
		animation_player.play('run')
		has_played_to_idle = false
	elif character.velocity.x == 0:
		legs.animation = 'idle'
		if not has_played_to_idle:
			animation_player.play("to_idle")
			has_played_to_idle = true
		
	if character.velocity.x > 0:
		legs.flip_h = false
	if character.velocity.x < 0:
		legs.flip_h = true
			
	legs.play()
	

	if is_aiming:
		current_aiming_time += _delta
		animation_player.play("pistol")
		if (weapon_angle >= 30 and weapon_angle <= 90) or (weapon_angle <= 150 and weapon_angle >= 90):
			animation_player.play("pistol_aiming_down")
		if current_aiming_time >= max_aiming_time or current_item == null:
			is_aiming = false
			arms.rotation = 0
			current_aiming_time = 0
			has_played_to_idle = false
		
			
		
	
	
	
