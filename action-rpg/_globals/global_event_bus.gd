class_name EventBus extends Node

# Player events
@warning_ignore("unused_signal") signal player_loaded(player : Player)

# Game events
@warning_ignore("unused_signal") signal game_paused
@warning_ignore("unused_signal") signal game_unpaused
@warning_ignore("unused_signal") signal restart

# Map events
@warning_ignore("unused_signal") signal load_next_map(position : Vector2)
@warning_ignore("unused_signal") signal camera_transition_finished
