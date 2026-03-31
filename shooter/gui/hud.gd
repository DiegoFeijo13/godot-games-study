class_name Hud extends Control

@onready var hp_bar: ProgressBar = $HpBar/ProgressBar
@onready var xp_bar: ProgressBar = $XpBar/ProgressBar
@onready var level_label: Label = $LevelLabel
@onready var game_over_ui: Control = $"../GameOverUI"

func _ready() -> void:
	GlobalEventBus.update_hpbar.connect(_on_update_hp)
	GlobalEventBus.update_xpbar.connect(_on_update_xp)
	GlobalEventBus.level_up.connect(_on_level_up)
	GlobalEventBus.player_died.connect(_on_game_over)

func _on_update_hp(current_value : float, max_value : float) -> void:
	if max_value <= 0:
		return
	hp_bar.value = _calculate_percent(current_value, max_value)

func _on_update_xp(current_value : float, max_value : float) -> void:
	if max_value <= 0:
		return	
	xp_bar.value = _calculate_percent(current_value, max_value)

func _on_level_up(level : int) -> void:
	level_label.text = str(level)

func _on_game_over() -> void:
	game_over_ui.visible = true

func _on_restart_button_button_up() -> void:
	GlobalEventBus.restart.emit()

func _calculate_percent(c : float, m : float) -> float:
	return (c / m) * 100
