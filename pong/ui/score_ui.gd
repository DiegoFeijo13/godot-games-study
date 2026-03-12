class_name ScoreUi extends Control

@onready var left_score: Label = $LeftScore
@onready var right_score: Label = $RightScore

func _ready() -> void:
	GlobalEventBus.update_score_ui.connect(_on_score_update)

func _on_score_update() -> void:
	left_score.text = str(GlobalGameState.score_left)
	right_score.text = str(GlobalGameState.score_right)
