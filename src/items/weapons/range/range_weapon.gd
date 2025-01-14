extends Weapon
class_name RangeWeapon

@export var ammunition: int = 40
@export var projectile_scene: PackedScene

var muzzle: Node2D


	
func attack():
	shoot()
	
func shoot():
	if ammunition > 0:
		var projectile: Projectile = projectile_scene.instantiate()
		if not muzzle:
			connect_muzzle()
		projectile.global_position = muzzle.global_position
		projectile.global_rotation = muzzle.global_rotation
		Utilities.get_level().add_child(projectile)
		ammunition -= 1

func connect_muzzle():
	muzzle = Utilities.find_nodes_by_name(get_inventory_owner(), "Muzzle")[0]
	
