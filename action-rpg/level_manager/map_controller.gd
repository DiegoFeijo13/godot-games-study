class_name MapController extends Node

@export var maps : Array[MapData]

const MAP_SIZE : Vector2 = Vector2(256,176)

var current_map : MapData = null
var current_map_node : Map = null

var last_map_node : Map = null

func _ready() -> void:
	if GlobalLevelManager.next_map_name.is_empty() == false:
		var map_data : MapData = _get_map_by_name(GlobalLevelManager.next_map_name)
		get_tree().paused = true
		_load_map(map_data, Vector2.ZERO)
		current_map = map_data
		get_tree().paused = false
		
	if current_map == null and maps.size() > 0:
		get_tree().paused = true
		_load_map(maps[0], Vector2.ZERO)
		current_map = maps[0]
		get_tree().paused = false
	
	GlobalEventBus.camera_move_to.connect(_on_camera_move_to)
	GlobalEventBus.camera_transition_finished.connect(_on_camera_transition_finished)

func _load_map(map_data : MapData, pos : Vector2) -> void:
	var map_node : Map = map_data.map_packed_scene.instantiate() as Map
	map_node.name = map_data.map_name
	map_node.global_position = pos		
	
	current_map_node = map_node
	
	call_deferred("add_child", map_node)	

func _get_map_by_name(map_name : String) -> MapData:
	var i : int = maps.find_custom(func(m : MapData) -> bool : return m.map_name == map_name)
	if i == -1:
		return null
	return maps[i]

func _on_camera_move_to(pos : Vector2) -> void:
	var next_map : MapData = null	
	var next_map_pos : Vector2 = current_map_node.position
	
	match pos:
		Vector2.UP:
			next_map = _get_map_by_name(current_map.top_map_name)
			next_map_pos.y -= MAP_SIZE.y
		Vector2.DOWN:
			next_map = _get_map_by_name(current_map.bottom_map_name)
			next_map_pos.y += MAP_SIZE.y
		Vector2.LEFT:
			next_map = _get_map_by_name(current_map.left_map_name)
			next_map_pos.x -= MAP_SIZE.x
		Vector2.RIGHT:
			next_map = _get_map_by_name(current_map.right_map_name)
			next_map_pos.x += MAP_SIZE.x
	
	if next_map == null:
		return
	
	get_tree().paused = true
	current_map = next_map
	last_map_node = current_map_node
	_load_map(next_map, next_map_pos)

func _on_camera_transition_finished() -> void:
	if last_map_node:
		last_map_node.queue_free()
	get_tree().paused = false
