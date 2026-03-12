class_name RightPaddle extends CharacterBody2D

const SPEED = 290.0
const DELAY_MIN = 0.9
const DELAY_MAX = 1.1
const DEAD_ZONE = 64.0

@export var ball : Ball

var move_delay : float
var ball_in_range : bool = false

var move_to : float

func _physics_process(_delta: float) -> void:	
	if move_delay > 0:
		move_delay -= _delta	
	move_delay = max(move_delay, 0.0)
	
	check_ball_in_range()		
	set_move_to()
	
	if ball_in_range:		
		position.y = move_toward(position.y, move_to, _delta * SPEED)
	else:
		position.y = move_toward(position.y, 0, _delta * SPEED)


func check_ball_in_range() -> void:
	if ball == null:
		return
	
	# ball is in range when moving right, in right court, 
	# and not in the dead zone
	ball_in_range = (
		ball.velocity.x > 0 
		&& ball.position.x > 0 
		&& abs(ball.position.y - position.y) > DEAD_ZONE
	)

func set_move_to() -> void:
	if move_delay > 0:
		return
	
	move_delay = randf_range(DELAY_MIN, DELAY_MAX)
	move_to = ball.position.y
