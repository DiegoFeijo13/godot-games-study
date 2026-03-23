class_name GameState extends Node

const START_LIVES = 3

var paddle : Paddle
var score : int
var lives : int
var bricks : int
var current_round : int = 0
var is_paused : bool = true
var is_game_over = false

var strategies = [
	WallStrategy.new(),
	ChessboardStrategy.new(),
	TriangleStrategy.new(),
	FortStrategy.new(),
	ChaosStrategy.new()
]
var current_strategy : BaseStrategy

func _ready() -> void:
	_new_game()
	GlobalEventBus.update_score.connect(_on_update_score)
	GlobalEventBus.ball_lost.connect(_on_ball_lost) 	
	GlobalEventBus.next_round.connect(_on_next_round)
	GlobalEventBus.pause_pressed.connect(_on_pause_pressed)

func _new_game() -> void:
	current_round = 0
	is_game_over = false
	is_paused = false
	_reset()	
	GlobalEventBus.next_round.emit()

func _on_update_score(score_points : int) -> void:
	score += score_points	
	bricks -= 1
	GlobalEventBus.update_ui.emit()
	if bricks <= 0:
		GlobalEventBus.next_round.emit()

func _on_ball_lost() -> void:
	lives -= 1
	if lives < 0:
		is_game_over = true
		GlobalEventBus.game_over.emit()
	GlobalEventBus.update_ui.emit()

func _reset() -> void:
	lives = START_LIVES
	score = 0
	GlobalEventBus.update_ui.emit()

func _on_next_round() -> void:
	current_round += 1
	if current_round <= 5:
		current_strategy = strategies[(current_round-1) % strategies.size()]
	else:
		current_strategy = strategies[randi_range(0, strategies.size()-1)]

	GlobalEventBus.update_ui.emit()

func _on_pause_pressed() -> void:
	if is_game_over:
		_new_game()
	else:
		if is_paused == true:
			is_paused = false		
		else:
			is_paused = true		
	
	GlobalEventBus.update_ui.emit()
