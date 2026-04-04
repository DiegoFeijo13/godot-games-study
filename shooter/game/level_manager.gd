class_name LevelManager extends Node2D

@onready var main_container: Node2D = $MainContainer

var _is_paused : bool = false


func _unhandled_input(_e: InputEvent) -> void:
	if Input.is_action_just_pressed("cancel") and GlobalGameState.can_player_control:
		if _is_paused:
			_on_unpause()
		else:
			_on_pause()		

func _on_pause() -> void:	
	get_tree().paused = true
	_is_paused = true
	GlobalEventBus.game_paused.emit()

func _on_unpause() -> void:		
	get_tree().paused = false
	_is_paused = false
	GlobalEventBus.game_unpaused.emit()
