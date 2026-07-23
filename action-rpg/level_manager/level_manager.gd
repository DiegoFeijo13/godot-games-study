class_name LevelManager extends Node

var maps : Array[Map]

@export var first_map : Map

var current_map : Map

func _ready() -> void:
	current_map = first_map
	_fetch_maps()
	GlobalEventBus.load_next_map.connect(_on_load_next_map)
	GlobalEventBus.camera_transition_finished.connect(_on_camera_transition_finished)

func _on_load_next_map(pos : Vector2) -> void:
	var next_map : Map = null	
	
	match pos:
		Vector2.UP:
			next_map = current_map.top_map
		Vector2.DOWN:
			next_map = current_map.bottom_map
		Vector2.LEFT:
			next_map = current_map.left_map 
		Vector2.RIGHT:
			next_map = current_map.right_map
	
	if next_map == null:
		return
	
	get_tree().paused = true
	_disable_all_maps()
	current_map = next_map

func _fetch_maps() -> void:
	for c in get_children():
		if c is Map:
			maps.append(c)

func _disable_all_maps() -> void:
	for m in maps:
		m.process_mode = Node.PROCESS_MODE_DISABLED
	
func _on_camera_transition_finished() -> void:
	current_map.process_mode = Node.PROCESS_MODE_INHERIT
	get_tree().paused = false
