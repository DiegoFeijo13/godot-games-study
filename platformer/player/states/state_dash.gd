class_name PlayerStateDash extends PlayerState

const ANIM_NAME = "dash"
const DASH_VELOCITY : float = 350.0
const DASH_TIME : float = 0.3

@onready var idle: PlayerStateIdle = $"../Idle"
@onready var walk: PlayerStateWalk = $"../Walk"
@onready var fall: PlayerStateFall = $"../Fall"
@onready var wall_slide: PlayerStateWallSlide = $"../WallSlide"

var current_dash_time : float = 0.0

func enter() -> void:
	#player.update_animation(ANIM_NAME)
	player.dash_requested = false
	player.velocity.x = player.looking_direction * DASH_VELOCITY
	player.velocity.y = 0
	current_dash_time = DASH_TIME
	pass
	
func exit() -> void:
	player.start_dash_cooldown()
	pass

func process(_delta : float) -> PlayerState:
	current_dash_time -= _delta
	player.update_x_velocity()
	
	if current_dash_time > 0:
		return null
	
	if !player.is_on_floor():
		return fall
	
	if player.direction == 0 and player.velocity == Vector2.ZERO:
		return idle
	
	return walk
	

func physics(_delta : float) -> void:
	pass
