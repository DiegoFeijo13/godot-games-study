class_name GameController extends Node

@onready var tile_map_layer: TileMapLayer = $Foreground


func _ready() -> void:
	GlobalEventBus.update_camera_bounds.emit(tile_map_layer)
