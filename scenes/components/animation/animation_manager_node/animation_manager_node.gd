extends Node
class_name AnimationManagerNode

@export var animation_requestors: Array[Node]
@export var animation_players: Array[Node]
@export var trigger_update_animation_players: bool = true
@export var trigger_update_animation_requestors: bool = true
@export var animation_manager_tag: String

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if trigger_update_animation_players:
		trigger_update_animation_players = false
		update_animation_players()
	
	if trigger_update_animation_requestors:
		trigger_update_animation_requestors = false
		update_animation_requestors()
	

func update_animation_requestors():
	# Отключаем сигналы от старых реквестеров
	for requestor in animation_requestors:
		SignalUtilities.safe_disconnect(requestor, "animation_signal", self, "_on_animation_requestor_animation_requested")
	
	# Обновляем список реквестеров
	var search_criteria = NodeFinder.SearchCriteria.new()
	search_criteria.signal_name = "animation_signal"
	animation_requestors = NodeFinder.find_nodes(get_parent(), search_criteria, NodeFinder.SearchDirection.DOWN, true)
	
	for requestor in animation_requestors:
		SignalUtilities.safe_connect(requestor, "animation_signal", self, "_on_animation_requestor_animation_requested")

func update_animation_players():
	var all_players = get_parent().find_children("*", "AnimationPlayer", true, false)
	animation_players = all_players.filter(func(player): return player.get_meta("animation_manager_tag", "") == animation_manager_tag)
	
func _on_animation_requestor_animation_requested(animation_name: String, speed_scale: float = 1):
	play_animation(animation_name, speed_scale)

func play_animation(animation_name: String, speed_scale: float = 1):
	for animation_player: AnimationPlayer in animation_players:
		if not animation_player.has_animation(animation_name):
			continue
		if animation_player.current_animation == animation_name and animation_player.is_playing():
			if animation_player.speed_scale == speed_scale:
				continue 
			animation_player.speed_scale = speed_scale  
			continue
		animation_player.speed_scale = speed_scale
		animation_player.play(animation_name)  
