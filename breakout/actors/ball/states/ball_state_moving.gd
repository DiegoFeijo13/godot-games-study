class_name BallStateMoving extends BallState

const START_SPEED = 300.0
const SPEED_STEP = 0.5
const MAX_SPEED = 1200.0

var current_speed : float

func init() -> void:
	pass

func enter() -> void:
	var direction := get_start_direction()
	current_speed = START_SPEED
	ball.velocity = direction * current_speed	

func exit() -> void:
	pass

func process(_d : float) -> BallState:
	return null

func physics(_d : float) -> BallState:
	if GlobalGameState.is_paused || GlobalGameState.is_game_over:
		return
		
	if ball.move_and_slide():
		var normal := ball.get_last_slide_collision().get_normal()
		change_dir_by_normal(normal)
	return null

func get_start_direction() -> Vector2 :
	#var x := randi_range(0, 1)	
	var x : int = 1
	if GlobalGameState.paddle.velocity.x >= 0:
		x = -1
	return Vector2(x,-1)

func change_dir_by_normal(normal : Vector2) -> void:		
	var new_dir := ball.velocity.normalized()	
	
	# hits the walls, reset the speed
	if normal.x == 0:
		current_speed += SPEED_STEP
		new_dir.y *= -1
	
	# hits the paddles (or the left/right walls) apply multiplier
	if normal.y ==0:		
		current_speed += SPEED_STEP	
		new_dir.x *= -1
	
	ball.velocity = new_dir * current_speed
