class_name EventBus extends Node

# Player events
@warning_ignore("unused_signal") signal set_player_parent(node : Node2D)
@warning_ignore("unused_signal") signal remove_player_parent(node : Node2D)
@warning_ignore("unused_signal") signal player_spawn(pos : Vector2)
@warning_ignore("unused_signal") signal set_player_position(new_pos : Vector2)
@warning_ignore("unused_signal") signal player_heal(value : int)
@warning_ignore("unused_signal") signal player_take_damage(value : int)
@warning_ignore("unused_signal") signal player_get_gold(value : int)
@warning_ignore("unused_signal") signal player_lose_gold(value : int)
@warning_ignore("unused_signal") signal player_pickup_item(drop : ItemDropData)
@warning_ignore("unused_signal") signal player_equip_tool(tool_type : GlobalConstants.TOOL_TYPES)


# HUD events
@warning_ignore("unused_signal") signal player_hp_updated(current_hp : int, max_hp : int)
@warning_ignore("unused_signal") signal player_gold_updated(current_gold : int)
@warning_ignore("unused_signal") signal player_key_count_updated(current_key_count : int)
@warning_ignore("unused_signal") signal player_arrow_count_updated(current_arrow_count : int)
@warning_ignore("unused_signal") signal show_pause_menu()
@warning_ignore("unused_signal") signal hide_pause_menu()

# Game events
@warning_ignore("unused_signal") signal game_paused
@warning_ignore("unused_signal") signal game_unpaused
@warning_ignore("unused_signal") signal restart

# Camera Events
@warning_ignore("unused_signal") signal camera_transition_finished
@warning_ignore("unused_signal") signal set_camera_position(pos : Vector2)
@warning_ignore("unused_signal") signal camera_move_to(position : Vector2)

# Map events
@warning_ignore("unused_signal") signal clear_next_map_name()
@warning_ignore("unused_signal") signal load_new_scene(path : String, player_position : Vector2, next_map_path : String)
@warning_ignore("unused_signal") signal scene_load_start()
@warning_ignore("unused_signal") signal scene_load_end()
