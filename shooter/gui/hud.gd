class_name Hud extends Control

const PAUSED_POS_Y : float = 0.0
const IN_GAME_POS_Y : float = 584.0

@onready var hp_bar: ProgressBar = $HpBar/ProgressBar
@onready var xp_bar: ProgressBar = $XpBar/ProgressBar
@onready var level_label: Label = $LevelLabel
@onready var game_over_ui: Control = $"../GameOverUI"

var is_paused : bool  = false

func _ready() -> void:
	GlobalEventBus.update_hpbar.connect(_on_update_hp)
	GlobalEventBus.update_xpbar.connect(_on_update_xp)
	GlobalEventBus.level_up.connect(_on_level_up)
	
func _process(_delta: float) -> void:
	if is_paused and position.y != PAUSED_POS_Y:
		position.y = move_toward(position.y, PAUSED_POS_Y, 300)
	
	if is_paused == false and position.y != IN_GAME_POS_Y:
		position.y = move_toward(position.y, IN_GAME_POS_Y, 300)
	
func _on_update_hp(current_value : float, max_value : float) -> void:
	if max_value <= 0:
		return
	hp_bar.value = _calculate_percent(current_value, max_value)

func _on_update_xp(current_value : float, max_value : float) -> void:
	if max_value <= 0:
		return	
	xp_bar.value = _calculate_percent(current_value, max_value)

func _on_level_up(_levels_gained : int, current_level : int) -> void:
	level_label.text = str(current_level)

func _calculate_percent(c : float, m : float) -> float:
	return (c / m) * 100
