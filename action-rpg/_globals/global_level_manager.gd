class_name LevelManager extends Node

var next_map_name : String

func _ready() -> void:	
	GlobalEventBus.load_new_scene.connect(_on_load_new_scene)	
	GlobalEventBus.clear_next_map_name.connect(_on_clear_next_map_name)

func _on_load_new_scene (
		level_path: String,
		target_position: Vector2,
		next_map: String
) -> void:
	call_deferred("_load_new_scene", level_path, target_position, next_map)
	

func _load_new_scene(level_path: String, target_position : Vector2, next_map: String) -> void:
	next_map_name = next_map
	get_tree().paused = true		
	
	GlobalEventBus.scene_load_start.emit()
	
	#await SceneTransition.fade_out()	
	get_tree().change_scene_to_file( level_path )
	
	print("target_position: ", target_position)
	GlobalEventBus.player_spawn.emit(target_position)
	
	get_tree().paused = false	
	
	#await SceneTransition.fade_in()	
	GlobalEventBus.scene_load_end.emit()

func _on_clear_next_map_name() -> void:
	next_map_name = ""
