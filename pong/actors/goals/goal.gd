extends Area2D

enum SideEnum{LEFT, RIGHT}
@export var side : SideEnum


func _on_area_entered(_a: Area2D) -> void:
	if side == SideEnum.LEFT:
		GlobalGameState.add_score_right()
	
	if side == SideEnum.RIGHT:
		GlobalGameState.add_score_left()
