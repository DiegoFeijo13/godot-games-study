class_name EventBus extends Node

signal next_round
signal update_score(score_points : int)
signal update_ui
signal ball_lost
signal life_lost
signal game_over

signal action_pressed
signal pause_pressed

signal power_up_spawn
signal power_up_despawn
signal got_power_up(power_up : PowerUp)
signal lost_power_up

signal spawn_extra_ball

signal slow_ball_speed
