class_name LevelManager extends Node

var current_map : Map

func _ready() -> void:
	GlobalEventBus.set_current_map.connect(_on_set_current_map)
	GlobalEventBus.camera_transition_finished.connect(_on_camera_transition_finished)

func _on_set_current_map (map : Map) -> void:
	current_map = map	

func _on_camera_transition_finished() -> void:
	current_map.process_mode = Node.PROCESS_MODE_INHERIT
	get_tree().paused = false
