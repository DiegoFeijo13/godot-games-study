extends Camera2D

var next_pos: Vector2

func _physics_process(_delta: float) -> void:
	if global_position != next_pos:
		global_position = global_position.move_toward(next_pos, 8)


func _on_top_area_body_entered(_body: Node2D) -> void:
	next_pos = global_position - Vector2(0, 176)

func _on_bottom_area_body_entered(_body: Node2D) -> void:
	print("bottom")
	next_pos = global_position + Vector2(0, 176)

func _on_left_area_body_entered(_body: Node2D) -> void:
	next_pos = global_position - Vector2(256, 0)

func _on_right_area_body_entered(_body: Node2D) -> void:
	next_pos = global_position + Vector2(256, 0)
