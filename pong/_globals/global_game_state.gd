class_name GameState extends Node

var score_left : int = 0
var score_right : int = 0

func _ready() -> void:
	GlobalEventBus.set_score.connect(_on_set_score)

func _process(_delta: float) -> void:
	if Input.is_action_pressed("start"):
		GlobalEventBus.new_round.emit()
	pass

func _on_set_score(_side : int) -> void:
	if _side == 0:
		score_right +=1
	if _side == 1:
		score_left += 1
	
	GlobalEventBus.new_round.emit()
	GlobalEventBus.update_score_ui.emit()
