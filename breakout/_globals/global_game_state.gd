class_name GameState extends Node

const START_LIVES = 3
const POWER_UP_CHANCE : float = 0.05

var paddle : Paddle
var score : int
var lives : int
var bricks : int
var current_round : int = 0
var is_paused : bool = true
var is_game_over : bool = false
var has_power_up_on_screen : bool = false

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
	GlobalEventBus.life_lost.connect(_on_life_lost) 	
	GlobalEventBus.next_round.connect(_on_next_round)
	GlobalEventBus.pause_pressed.connect(_on_pause_pressed)
	GlobalEventBus.power_up_spawn.connect(_on_power_up_spawn)
	GlobalEventBus.power_up_despawn.connect(_on_power_up_despawn)
	GlobalEventBus.got_power_up.connect(_on_power_up_got)

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

func _on_life_lost() -> void:
	lives -= 1
	if lives < 0:
		is_game_over = true
		GlobalEventBus.game_over.emit()
	GlobalEventBus.lost_power_up.emit()
	GlobalEventBus.update_ui.emit()

func _reset() -> void:
	lives = START_LIVES
	score = 0
	GlobalEventBus.update_ui.emit()

func _on_next_round() -> void:
	current_round += 1
	if current_round > 99:
		is_game_over = true
		GlobalEventBus.game_over.emit()
		return
	
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

func _on_power_up_spawn() -> void:
	has_power_up_on_screen = true

func _on_power_up_despawn() -> void:
	has_power_up_on_screen = false

func _on_power_up_got(_p : PowerUp) -> void:
	has_power_up_on_screen = false
	if _p.type == _p.Power_Type.OneUp:
		lives += 1
		GlobalEventBus.update_ui.emit()
	
	if _p.type == _p.Power_Type.ExtraBall:
		GlobalEventBus.spawn_extra_ball.emit()
	
	if _p.type == _p.Power_Type.Slow:
		GlobalEventBus.slow_ball_speed.emit()
		
func current_power_up_chance() -> float:
	return clampf(POWER_UP_CHANCE * current_round, POWER_UP_CHANCE, 0.5)
