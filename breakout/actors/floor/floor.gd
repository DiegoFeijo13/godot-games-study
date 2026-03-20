class_name Floor extends Area2D

func ball_lost() -> void:
	print("ball_lost")
	GlobalEventBus.ball_lost.emit()
