class_name EventBus extends Node

# Player events
@warning_ignore("unused_signal") signal player_loaded(player : Player)

# Game events
@warning_ignore("unused_signal") signal game_paused
@warning_ignore("unused_signal") signal game_unpaused
@warning_ignore("unused_signal") signal restart
