class_name GameState extends Node

var can_player_control : bool = true

func _ready() -> void:
	GlobalEventBus.restart.connect(_on_restart)

func _on_restart() -> void:
	get_tree().paused = true
	get_tree().create_timer(0.5).timeout.connect(_restart)

func _restart() -> void:
	get_tree().reload_current_scene()
	get_tree().paused = false

	
