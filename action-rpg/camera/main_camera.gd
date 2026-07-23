extends Camera2D

const camera_size : Vector2 = Vector2(256,176)
var next_pos: Vector2
var is_moving : bool

func _physics_process(_delta: float) -> void:
	if global_position == next_pos and is_moving:
		is_moving = false
		GlobalEventBus.camera_transition_finished.emit()
		
	if global_position != next_pos:
		global_position = global_position.move_toward(next_pos, 8)

func _on_top_area_area_entered(_body: Node2D) -> void:	
	_load_next_map(Vector2.UP)

func _on_bottom_area_area_entered(_body: Node2D) -> void:		
	_load_next_map(Vector2.DOWN)
	
func _on_left_area_area_entered(_body: Node2D) -> void:	
	_load_next_map(Vector2.LEFT)

func _on_right_area_area_entered(_body: Node2D) -> void:	
	_load_next_map(Vector2.RIGHT)

func _load_next_map(pos:Vector2) -> void:
	GlobalEventBus.load_next_map.emit(pos)	
	next_pos = global_position + (pos * camera_size)
	is_moving = true
