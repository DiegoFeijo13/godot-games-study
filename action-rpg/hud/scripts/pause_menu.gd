class_name PauseMenu extends CanvasLayer

var is_paused : bool = false

func _ready() -> void:
	hide_pause_menu()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause")	:
		if is_paused == false:
			show_pause_menu()
		else:
			hide_pause_menu()
		get_viewport().set_input_as_handled()

func show_pause_menu() -> void:
	get_tree().paused = true
	visible = true
	is_paused = true		
	
func hide_pause_menu() -> void:
	get_tree().paused = false
	visible = false	
	is_paused = false		
	
