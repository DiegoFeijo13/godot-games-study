class_name GameState extends Node

var paddle : Paddle
var score : int
var lives : int
var bricks : int
var current_round : int = 1

func _ready() -> void:
	reset()
	GlobalEventBus.update_score.connect(on_update_score)
	GlobalEventBus.ball_lost.connect(on_ball_lost) 	
	GlobalEventBus.next_round.connect(on_next_round)

func on_update_score(score_points : int) -> void:
	score += score_points	
	bricks -= 1
	GlobalEventBus.update_ui.emit()
	if bricks <= 0:
		GlobalEventBus.next_round.emit()

func on_ball_lost() -> void:
	lives -= 1
	GlobalEventBus.update_ui.emit()

func reset() -> void:
	lives = 3
	score = 0
	GlobalEventBus.update_ui.emit()

func on_next_round() -> void:
	# todo: decide which strategy to use
	current_round += 1
	GlobalEventBus.update_ui.emit()
