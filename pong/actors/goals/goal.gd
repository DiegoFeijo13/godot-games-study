class_name Goal extends Area2D

enum SideEnum{LEFT, RIGHT}
@export var side : SideEnum

func _on_area_entered(_a: Area2D) -> void:
	GlobalEventBus.set_score.emit(side)	
