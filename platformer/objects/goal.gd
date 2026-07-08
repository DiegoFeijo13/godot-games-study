class_name Goal extends Node2D

@export var expected_coins : int = 100

@onready var area_2d: Area2D = $Area2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	GlobalEventBus.player_reached_goal.emit(expected_coins)
