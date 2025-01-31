extends Item
class_name Weapon

@export var bullet_scene: PackedScene
@export var attack_speed: float = 0.1
var attack_speed_timer: float = 0
var muzzle_component: Muzzle = null


func use():
	if attack_speed_timer >= attack_speed and muzzle_component:
		attack_speed_timer = 0
		var bullet = bullet_scene.instantiate()
		if bullet is Node2D:
			Utilities.get_level().add_child(bullet)
			bullet.global_position = muzzle_component.global_position
			bullet.global_rotation = muzzle_component.global_rotation

func _process(delta: float) -> void:
	attack_speed_timer += delta
	
func get_in_inventory(inventory: Inventory):
	super(inventory)
	muzzle_component = Utilities.find_nodes_by_class_name(inventory.owner, "Muzzle")[0]

func get_dropped(drop_position: Vector2):
	super(drop_position)
	muzzle_component = null
	
