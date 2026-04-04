class_name GuiManager extends Node

@onready var upgrade_choices_ui: UpgradeChoicesUI = $UpgradeChoicesUI
@onready var hud: Hud = $HUD
@onready var game_over_ui: Control = $GameOverUI

func _ready() -> void:
	_toggle_visible(false)
	hud.visible = true
	GlobalEventBus.player_died.connect(_on_game_over)
	GlobalEventBus.update_upgrade_choices.connect(_on_update_upgrade_choices)
	GlobalEventBus.ui_chose_upgrade.connect(_on_upgrade_select)
	GlobalEventBus.game_paused.connect(_on_game_paused)
	GlobalEventBus.game_unpaused.connect(_on_game_unpaused)

func _on_update_upgrade_choices(choices : Array[UpgradeData]) -> void:
	_toggle_visible(false)
	upgrade_choices_ui.visible = true
	upgrade_choices_ui.update_buttons(choices)
	
func _on_game_over() -> void:
	_toggle_visible(false)
	game_over_ui.visible = true	

func _on_upgrade_select(upgrade : UpgradeData) -> void:
	_toggle_visible(false)
	GlobalEventBus.pickup_upgrade.emit(upgrade)

func _toggle_visible(visible : bool) -> void:
	game_over_ui.visible = visible
	upgrade_choices_ui.visible = visible

func _on_game_paused() -> void:
	_toggle_visible(false)
	hud.is_paused = true

func _on_game_unpaused() -> void:
	_toggle_visible(false)
	hud.is_paused = false
