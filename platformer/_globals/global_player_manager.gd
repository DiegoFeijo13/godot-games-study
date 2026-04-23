extends Node

var player : Player

func _ready() -> void:
	GlobalEventBus.player_loaded.connect(_on_player_loaded)

func _on_player_loaded(_player : Player) -> void:
	player = _player


func get_player_global_position() -> Vector2:
	if player:
		return player.global_position
	return Vector2.ZERO

func get_player_current_level() -> int:
	if player:
		return player._level
	return 0
