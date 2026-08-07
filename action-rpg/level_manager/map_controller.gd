class_name MapController extends Node

var maps : Array[Map]

@export var first_map : Map

func _ready() -> void:
	if GlobalLevelManager.current_map == null:
		GlobalEventBus.set_current_map.emit(first_map)	
	
	_fetch_maps()
	
	if GlobalGameManager.next_map_name.is_empty() == false:
		_set_current_map_by_path()
	
	GlobalEventBus.load_next_map.connect(_on_load_next_map)		

func _on_load_next_map(pos : Vector2) -> void:
	var next_map : Map = null	
	var current_map = GlobalLevelManager.current_map
	
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
	GlobalEventBus.set_current_map.emit(next_map)

func _fetch_maps() -> void:
	for c in get_children():
		if c is Map:
			maps.append(c)
			print(c.position, c.global_position)

func _disable_all_maps() -> void:
	for m in maps:
		m.process_mode = Node.PROCESS_MODE_DISABLED
	
func _set_current_map_by_path() -> void:
	var map_name = GlobalGameManager.next_map_name
	
	for m in maps:
		if m.name == map_name:
			GlobalEventBus.set_current_map.emit(m)
			GlobalEventBus.set_camera_position.emit(m.position)
			GlobalEventBus.clear_next_map_name.emit()			
			return
