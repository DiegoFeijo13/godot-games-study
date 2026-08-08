class_name MapController extends Node

@export var maps : Array[MapData]
var loaded_maps : Array[Map]

const MAP_SIZE : Vector2 = Vector2(256,176)

var current_map : MapData = null

func _ready() -> void:
	if GlobalLevelManager.next_map_name.is_empty() == false:
		var map_data = _get_map_by_name(GlobalLevelManager.next_map_name)
		get_tree().paused = true
		_load_map(map_data, Vector2.ZERO, true)
		current_map = map_data
		get_tree().paused = false
		
	if current_map == null and maps.size() > 0:
		get_tree().paused = true
		_load_map(maps[0], Vector2.ZERO, true)
		current_map = maps[0]
		get_tree().paused = false
	
	GlobalEventBus.camera_move_to.connect(_on_camera_move_to)
	GlobalEventBus.camera_transition_finished.connect(_on_camera_transition_finished)

func _load_map(map_data : MapData, pos : Vector2, load_adjacents : bool) -> void:
	#early out for already loaded maps
	if _get_loaded_map_by_name(map_data.map_name):
		return
	
	var map_node = map_data.map_packed_scene.instantiate() as Map
	map_node.name = map_data.map_name
	loaded_maps.append(map_node)
	map_node.global_position = pos		
		
	call_deferred("add_child", map_node)	
	
	if load_adjacents:
		_load_adjacent_maps(map_node, map_data)

func _load_adjacent_maps(map_node : Map, map_data : MapData) -> void:
	var top_map_data = _get_map_by_name(map_data.top_map_name)
	var bottom_map_data = _get_map_by_name(map_data.bottom_map_name)
	var left_map_data = _get_map_by_name(map_data.left_map_name)
	var right_map_data = _get_map_by_name(map_data.right_map_name)
			
	if top_map_data:
		var pos : Vector2 = map_node.position
		pos.y -= MAP_SIZE.y
		_load_map(top_map_data, pos, false)
	
	if bottom_map_data:
		var pos : Vector2 = map_node.position
		pos.y += MAP_SIZE.y
		_load_map(bottom_map_data, pos, false)
	
	if left_map_data:
		var pos : Vector2 = map_node.position
		pos.x -= MAP_SIZE.x
		_load_map(left_map_data, pos, false)
	
	if right_map_data:
		var pos : Vector2 = map_node.position
		pos.x += MAP_SIZE.x
		_load_map(right_map_data, pos, false)
	

func _get_map_by_name(map_name : String) -> MapData:
	var i = maps.find_custom(func(m : MapData): return m.map_name == map_name)
	if i == -1:
		return null
	return maps[i]

func _get_loaded_map_by_name(map_name : String) -> Map:
	var i = loaded_maps.find_custom(func(m : Map): return m.name == map_name)
	if i == -1:
		return null
	return loaded_maps[i]

func _disable_all_maps() -> void:
	for m in loaded_maps:
		m.process_mode = Node.PROCESS_MODE_DISABLED

func _on_camera_move_to(pos : Vector2) -> void:
	var next_map : Map = null
	
	match pos:
		Vector2.UP:
			next_map = _get_loaded_map_by_name(current_map.top_map_name)
		Vector2.DOWN:
			next_map = _get_loaded_map_by_name(current_map.bottom_map_name)
		Vector2.LEFT:
			next_map = _get_loaded_map_by_name(current_map.left_map_name)
		Vector2.RIGHT:
			next_map = _get_loaded_map_by_name(current_map.right_map_name)
	
	if next_map == null:
		return
	
	get_tree().paused = true
	var map_data = _get_map_by_name(next_map.name)
	_load_adjacent_maps(next_map, map_data)
	current_map = map_data
	_disable_all_maps()
	next_map.process_mode = Node.PROCESS_MODE_INHERIT

func _on_camera_transition_finished() -> void:	
	get_tree().paused = false
