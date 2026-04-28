class_name GameController extends Node

@onready var tile_map_layer: TileMapLayer = $TileMapLayer


func _ready() -> void:
	GlobalEventBus.update_camera_bounds.emit(tile_map_layer)
