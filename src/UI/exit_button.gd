extends Button

func _ready() -> void:
	pressed.connect(exit)

func exit():
	get_tree().quit()
