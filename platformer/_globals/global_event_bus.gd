class_name EventBus extends Node

# Player events
@warning_ignore("unused_signal") signal player_loaded(player : Player)
@warning_ignore("unused_signal") signal player_died
@warning_ignore("unused_signal") signal player_reached_goal(expected_coins : int)

# Object events
@warning_ignore("unused_signal") signal coin_collected

# Game events
@warning_ignore("unused_signal") signal update_camera_bounds(tml : TileMapLayer)
@warning_ignore("unused_signal") signal game_paused
@warning_ignore("unused_signal") signal game_unpaused
@warning_ignore("unused_signal") signal restart

# GUI events
@warning_ignore("unused_signal") signal update_ui(coins: int, deaths: int)
@warning_ignore("unused_signal") signal not_enough_coins
@warning_ignore("unused_signal") signal show_finish_dialog(coins: int, deaths: int)
