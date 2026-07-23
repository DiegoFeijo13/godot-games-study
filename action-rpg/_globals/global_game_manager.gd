class_name GameManager extends Node

var player : Player

func _ready() -> void:
	GlobalEventBus.player_loaded.connect(_on_player_loaded)
	
func _on_player_loaded(p:Player) -> void:
	player = p
