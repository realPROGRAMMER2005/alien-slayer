extends Item
class_name Weapon

@export var projectile_scene: PackedScene
@export var attack_speed: float = 0.2
var attack_speed_timer: float = 0
var muzzle_component: Muzzle = null


func use():
	if attack_speed_timer >= attack_speed and muzzle_component:
		attack_speed_timer = 0
		var projectile_instance = projectile_scene.instantiate()
		Utilities.get_level().add_child(projectile_instance)
		projectile_instance.global_position = muzzle_component.global_position
		projectile_instance.global_rotation = muzzle_component.global_rotation
		Utilities.find_nodes_by_class_name(projectile_instance, ProjectileMovement)[0].direction = Vector2(cos(muzzle_component.global_rotation), sin(muzzle_component.global_rotation)) 

func _physics_process(delta: float) -> void:
	attack_speed_timer += delta
	
func get_in_inventory(inventory: Inventory):
	super(inventory)
	muzzle_component = Utilities.get_component(inventory.owner, Muzzle)

func get_dropped(drop_position: Vector2):
	super(drop_position)
	muzzle_component = null
	
