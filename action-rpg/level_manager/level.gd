class_name Level extends Node2D

func _ready() -> void:
	GlobalEventBus.set_player_parent.emit(self)
	GlobalEventBus.scene_load_start.connect(_on_scene_load_start)

func _on_scene_load_start() -> void:
	GlobalEventBus.remove_player_parent.emit(self)
	queue_free()
