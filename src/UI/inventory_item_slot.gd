extends Control
var item: Item
@onready var label: Label = get_node("Button/Label")
@onready var icon: Sprite2D = get_node("Button/Icon")
@onready var button: Button = get_node("Button")
var normal_stylebox = preload("res://src/UI/item_slot_normal.tres")
var selected_stylebox = preload("res://src/UI/item_slot_selected_style_box.tres")

func _ready() -> void:
	button.disabled = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if item:
		icon.texture = item.inventory_icon
		if item is RangeWeapon:
			label.text = str(item.ammunition)
	else:
		label.text = ""

func apply_selected_style():
	$Button.add_theme_stylebox_override("disabled", selected_stylebox)

func apply_normal_style():
	$Button.add_theme_stylebox_override("disabled", normal_stylebox)
	
	
		
