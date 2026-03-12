class_name Ball extends CharacterBody2D

const START_SPEED = 300.0
const SPEED_STEP = 50.0
const MAX_SPEED = 1200.0

var current_speed : float

func _ready() -> void:	
	var direction := get_start_direction()
	current_speed = START_SPEED
	velocity = direction * current_speed	

func _physics_process(_delta: float) -> void:
	if move_and_slide():
		var normal := get_last_slide_collision().get_normal()
		change_dir_by_normal(normal)		

func get_start_direction() -> Vector2 :
	var x := randi_range(0, 1)	
	if x == 0:
		x = -1	
	return Vector2(x,-1)

func change_dir_by_normal(normal : Vector2) -> void:		
	var new_dir := velocity.normalized()	
	
	# hits the walls, reset the speed
	if normal.x == 0:
		current_speed += SPEED_STEP
		new_dir.y *= -1
	
	# hits the paddles (or the left/right walls) apply multiplier
	if normal.y ==0:		
		current_speed += SPEED_STEP	
		new_dir.x *= -1
	
	velocity = new_dir * current_speed
