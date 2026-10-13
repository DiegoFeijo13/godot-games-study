class_name GameManager extends Node

var in_dialog : bool
var in_menu : bool

func _ready() -> void:	
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	GlobalEventBus.show_pause_menu_finish.connect(_on_show_pause_menu_finish)
	GlobalEventBus.hide_pause_menu_finish.connect(_on_hide_pause_menu_finish)
	GlobalEventBus.player_started_dialog.connect(_on_start_dialog)
	GlobalEventBus.player_finished_dialog.connect(_on_finish_dialog)
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("start"):
		if in_dialog:
			return
		
		if in_menu:
			GlobalEventBus.hide_pause_menu_start.emit()
		else:
			get_tree().paused = true
			GlobalEventBus.show_pause_menu_start.emit()
		
func _on_show_pause_menu_finish() -> void:
	in_menu = true

func _on_hide_pause_menu_finish() -> void:
	in_menu = false
	get_tree().paused = false

func _on_start_dialog() -> void:
	if in_menu:
		return
	get_tree().paused = true
	in_dialog = true

func _on_finish_dialog() -> void:
	in_dialog = false
	get_tree().paused = false
