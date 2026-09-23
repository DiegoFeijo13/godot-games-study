class_name PauseMenu extends CanvasLayer

var is_paused : bool = false

@onready var main_control: Control = $Control
@onready var equips: HudEquips = $Control/Equips
@onready var tools: HudTools = $Control/Tools
@onready var info_label: Label = $Control/Info/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	hide_pause_menu()

func _unhandled_input(event: InputEvent) -> void:
	if animation_player.is_playing():
		return
	
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
	animation_player.play("slide_down")
	await animation_player.animation_finished
	
func hide_pause_menu() -> void:
	animation_player.play("slide_up")
	await animation_player.animation_finished
	get_tree().paused = false
	visible = false	
	is_paused = false		
	
func update_item_description(_desc : String) -> void:
	info_label.text = _desc
	pass
