class_name Floor extends Area2D

func ball_lost() -> void:
	GlobalEventBus.ball_lost.emit()
