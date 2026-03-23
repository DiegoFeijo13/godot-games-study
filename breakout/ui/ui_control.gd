extends Node

@onready var score_points: Label = $InGameUI/ScorePoints
@onready var lives_counter: Label = $InGameUI/LivesCounter
@onready var round_label: Label = $InGameUI/RoundLabel

@onready var in_game_ui: Control = $InGameUI
@onready var paused_game_ui: Control = $PausedGameUI
@onready var game_over_ui: Control = $GameOverUI

func _ready() -> void:	
	GlobalEventBus.update_ui.connect(_on_update_ui)
	_on_update_ui()

func _on_update_ui() -> void:
	in_game_ui.visible = false
	paused_game_ui.visible = false
	game_over_ui.visible = false
	
	if GlobalGameState.is_paused:
		paused_game_ui.visible = true
		return
	
	if GlobalGameState.is_game_over:
		game_over_ui.visible = true
		return
	
	in_game_ui.visible = true
	score_points.text = str(GlobalGameState.score)
	lives_counter.text = str(GlobalGameState.lives)
	round_label.text = "ROUND " + str(GlobalGameState.current_round)
