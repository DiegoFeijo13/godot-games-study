class_name PlayerStateWallSlide extends PlayerState

const ANIM_NAME = "wall_slide"
const WALL_SLIDE_X : float = 0.3

@onready var idle: PlayerStateIdle = $"../Idle"
@onready var walk: PlayerStateWalk = $"../Walk"

func enter() -> void:
	#player.update_animation(ANIM_NAME)		
	print("wall sliding")
	pass
	
func exit() -> void:
	print("not wall sliding")
	pass

func process(_delta : float) -> PlayerState:	
	if player.is_on_floor():
		if player.direction == 0:
			return idle
		return walk
	
	if !player.is_touching_left_wall and !player.is_touching_right_wall:
		return idle
	
	return null

func physics(_delta : float) -> void:
	var d_vel = player.velocity.y + (player.get_gravity().y * WALL_SLIDE_X * _delta)
	var cap = player.FALL_VELOCITY
	player.velocity.y = minf(d_vel, cap)
	pass



	
