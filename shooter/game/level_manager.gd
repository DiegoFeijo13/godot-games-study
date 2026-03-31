class_name LevelManager extends Node2D

@onready var main_container: Node2D = $MainContainer

func _unhandled_input(_e: InputEvent) -> void:
	if Input.is_action_pressed("pause") and GlobalGameState.player_can_control:
		_on_pause()		

func _on_pause() -> void:	
	get_tree().paused = !get_tree().paused
	GlobalEventBus.game_paused.emit(get_tree().paused)
