class_name Coin extends Node2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	GlobalEventBus.coin_collected.emit()
	queue_free()
