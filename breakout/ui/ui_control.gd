extends Node

@onready var score_points: Label = $ScorePoints
@onready var lives_counter: Label = $LivesCounter
@onready var round_label: Label = $RoundLabel

func _ready() -> void:	
	GlobalEventBus.update_ui.connect(on_update_ui)
	on_update_ui()

func on_update_ui() -> void:
	score_points.text = str(GlobalGameState.score)
	lives_counter.text = str(GlobalGameState.lives)
	round_label.text = "ROUND " + str(GlobalGameState.current_round)
