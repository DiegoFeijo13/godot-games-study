extends Node2D

func _ready() -> void:
	visible = false
	if GlobalPlayerManager.player_spawned == false:
		GlobalEventBus.set_player_position.emit( global_position )
