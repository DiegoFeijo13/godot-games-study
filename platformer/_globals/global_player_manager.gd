extends Node

var player : Player
var start_pos : Vector2

var coins : int = 0

func _ready() -> void:
	GlobalEventBus.player_loaded.connect(_on_player_loaded)
	GlobalEventBus.coin_collected.connect(_on_coin_collected)
	GlobalEventBus.player_died.connect(_on_player_died)

func _on_player_loaded(_player : Player) -> void:
	player = _player
	coins = 0
	start_pos = _player.global_position

func _on_player_died() -> void:
	player.global_position = start_pos

func get_player_global_position() -> Vector2:
	if player:
		return player.global_position
	return Vector2.ZERO

func _on_coin_collected() -> void:
	coins += 1
	print("Coins: ", coins)
