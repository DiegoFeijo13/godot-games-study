class_name EventBus extends Node

# Player events
@warning_ignore("unused_signal") signal set_player_parent(node : Node2D)
@warning_ignore("unused_signal") signal remove_player_parent(node : Node2D)
@warning_ignore("unused_signal") signal set_player_spawned(value : bool)
@warning_ignore("unused_signal") signal set_player_position(new_pos : Vector2)

# Game events
@warning_ignore("unused_signal") signal game_paused
@warning_ignore("unused_signal") signal game_unpaused
@warning_ignore("unused_signal") signal restart

# Camera Events
@warning_ignore("unused_signal") signal camera_transition_finished
@warning_ignore("unused_signal") signal set_camera_position(pos : Vector2)

# Map events
@warning_ignore("unused_signal") signal set_current_map(map : Map)
@warning_ignore("unused_signal") signal clear_next_map_name()
@warning_ignore("unused_signal") signal load_next_map(position : Vector2)
@warning_ignore("unused_signal") signal load_new_scene(path : String, player_position : Vector2, next_map_path : String)
@warning_ignore("unused_signal") signal scene_load_start()
@warning_ignore("unused_signal") signal scene_load_end()
