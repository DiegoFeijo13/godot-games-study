extends Node

var player : Player
var start_pos : Vector2

var coins : int = 0
var deaths : int = 0

func _ready() -> void:
	GlobalEventBus.player_loaded.connect(_on_player_loaded)
	GlobalEventBus.coin_collected.connect(_on_coin_collected)
	GlobalEventBus.player_died.connect(_on_player_died)
	GlobalEventBus.restart.connect(_on_restart)
	GlobalEventBus.player_reached_goal.connect(_on_player_reached_goal)

func _on_player_loaded(_player : Player) -> void:
	player = _player
	coins = 0
	start_pos = _player.global_position

func _on_player_died() -> void:
	deaths += 1
	player.global_position = start_pos
	_update_ui()

func _on_player_reached_goal(expected_coins : int) -> void:
	if coins < expected_coins:
		GlobalEventBus.not_enough_coins.emit()
	else:
		GlobalEventBus.show_finish_dialog.emit(coins, deaths)		

func _on_restart() -> void:
	deaths = 0
	coins = 0
	player.global_position = start_pos
	_update_ui()

func get_player_global_position() -> Vector2:
	if player:
		return player.global_position
	return Vector2.ZERO

func _on_coin_collected() -> void:
	coins += 1
	_update_ui()

func _update_ui() -> void:
	GlobalEventBus.update_ui.emit(coins, deaths)
