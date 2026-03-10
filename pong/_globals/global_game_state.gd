class_name GameState extends Node

var ball : Ball
var score_left : int = 0
var score_right : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("start"):
		ball.reset()
	pass

func add_score_left() -> void:
	score_left += 1
	print("Left: ", score_left, "Right: ", score_right)
	ball.reset()

func add_score_right() -> void:
	score_right += 1
	print("Left: ", score_left, "Right: ", score_right)
	ball.reset()
