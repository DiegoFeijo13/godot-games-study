class_name PauseMenu extends CanvasLayer

@onready var main_control: Control = $Control
@onready var equips: HudEquips = $Control/Equips
@onready var tools: HudTools = $Control/Tools
@onready var info_label: Label = $Control/Info/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	hide_pause_menu()
	GlobalEventBus.show_pause_menu_start.connect(show_pause_menu)
	GlobalEventBus.hide_pause_menu_start.connect(hide_pause_menu)

func show_pause_menu() -> void:
	equips.update_equips()
	tools.update_tools()
	visible = true	
	animation_player.play("slide_down")
	await animation_player.animation_finished
	GlobalEventBus.show_pause_menu_finish.emit()
	
func hide_pause_menu() -> void:
	animation_player.play("slide_up")
	await animation_player.animation_finished
	GlobalEventBus.hide_pause_menu_finish.emit()
	visible = false
	
func update_item_description(_desc : String) -> void:
	info_label.text = _desc
	pass
