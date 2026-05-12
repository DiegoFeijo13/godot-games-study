class_name PlayerStateIdle extends PlayerState

const ANIM_NAME = "idle"

@onready var walk: PlayerStateWalk = $"../Walk"
@onready var fall: PlayerStateFall = $"../Fall"
@onready var jump: PlayerStateJump = $"../Jump"
@onready var dash: PlayerStateDash = $"../Dash"

func enter() -> void:
	player.update_animation(ANIM_NAME)	
	
func exit() -> void:
	pass

func process(_delta : float) -> PlayerState:
	if !player.is_on_floor():
		return fall
	
	if player.direction != 0:
		return walk
	
	if player.jump_requested and player.can_jump():
		return jump
	
	if player.dash_requested:
		return dash
	
	return null

func physics(_delta : float) -> void:
	player.update_x_velocity()
	pass
			
