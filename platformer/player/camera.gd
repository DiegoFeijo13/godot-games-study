extends Camera2D

func _ready() -> void:
	GlobalEventBus.update_camera_bounds.connect(_on_update_bounds)

func _on_update_bounds(tml : TileMapLayer) -> void:
	var map_boundaries = tml.get_used_rect()
	var tile_size: Vector2i
	tile_size.x = tml.tile_set.tile_size.x
	tile_size.y = tml.tile_set.tile_size.y
	map_boundaries.position *= tile_size
	map_boundaries.size *= tile_size	
	limit_top = map_boundaries.position.y
	limit_left = map_boundaries.position.x
	limit_bottom = map_boundaries.end.y
	limit_right = map_boundaries.end.x
