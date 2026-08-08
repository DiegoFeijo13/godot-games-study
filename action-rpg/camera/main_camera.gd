extends Camera2D

const camera_size : Vector2 = Vector2(256,176)
var next_pos: Vector2
var is_moving : bool

func _ready() -> void:	
	GlobalEventBus.set_camera_position.connect(_on_set_position)

func _physics_process(_delta: float) -> void:
	if global_position == next_pos and is_moving:
		is_moving = false
		GlobalEventBus.camera_transition_finished.emit()
		
	if global_position != next_pos:
		global_position = global_position.move_toward(next_pos, 8)

func _on_top_area_area_entered(_body: Node2D) -> void:	
	_move_to(Vector2.UP)

func _on_bottom_area_area_entered(_body: Node2D) -> void:		
	_move_to(Vector2.DOWN)
	
func _on_left_area_area_entered(_body: Node2D) -> void:	
	_move_to(Vector2.LEFT)

func _on_right_area_area_entered(_body: Node2D) -> void:	
	_move_to(Vector2.RIGHT)

func _move_to(pos:Vector2) -> void:
	GlobalEventBus.camera_move_to.emit(pos)	
	get_tree().paused = true
	next_pos = global_position + (pos * camera_size)
	is_moving = true

func _on_set_position(pos : Vector2) -> void:
	print(pos)
	global_position = pos
