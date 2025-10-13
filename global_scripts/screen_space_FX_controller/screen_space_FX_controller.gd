extends Node


var screen_space_FX_animation_player: AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not screen_space_FX_animation_player:
		screen_space_FX_animation_player = get_tree().current_scene.find_child("ScreenSpaceFXAnimationPlayer")

func play_FX(FX_name: String):
	if screen_space_FX_animation_player.has_animation(FX_name):
		screen_space_FX_animation_player.play(FX_name)


	
	
