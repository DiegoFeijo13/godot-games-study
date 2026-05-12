class_name PlayerStateFall extends PlayerState

const ANIM_NAME = "fall"

@onready var idle: PlayerStateIdle = $"../Idle"
@onready var walk: PlayerStateWalk = $"../Walk"
@onready var wall_slide: PlayerStateWallSlide = $"../WallSlide"
@onready var dash: PlayerStateDash = $"../Dash"

func enter() -> void:
	#player.update_animation(ANIM_NAME)	
	pass
	
func exit() -> void:
	pass

func process(_delta : float) -> PlayerState:
	if player.is_on_floor():
		if player.direction != 0:
			return walk
		else:
			return idle
	
	if player.dash_requested:
		return dash
	
	if player.is_touching_wall():
		return wall_slide
	
	return null

func physics(_delta : float) -> void:
	player.velocity.y = minf(player.velocity.y + (player.get_gravity().y * player.FALL * _delta), player.FALL_VELOCITY)
	player.update_x_velocity()
			
