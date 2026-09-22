class_name PauseMenu extends CanvasLayer

var is_paused : bool = false

@onready var equips: HudEquips = $Equips
@onready var tools: HudTools = $Tools

func _ready() -> void:
	hide_pause_menu()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("start"):
		if is_paused == false and get_tree().paused == false:
			show_pause_menu()
		else:
			hide_pause_menu()
		get_viewport().set_input_as_handled()

func show_pause_menu() -> void:
	get_tree().paused = true
	equips.update_equips()
	tools.update_tools()
	visible = true
	is_paused = true		
	
func hide_pause_menu() -> void:
	get_tree().paused = false
	visible = false	
	is_paused = false		
	
func update_item_description(_desc : String) -> void:
	pass
