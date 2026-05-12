class_name PlayerStateWalk extends PlayerState

const ANIM_NAME = "walk"

@onready var idle: PlayerStateIdle = $"../Idle"
@onready var fall: PlayerStateFall = $"../Fall"
@onready var jump: PlayerStateJump = $"../Jump"
@onready var dash: PlayerStateDash = $"../Dash"

func enter() -> void:
	player.update_animation(ANIM_NAME)
	pass
	
func exit() -> void:
	pass

func process(_delta : float) -> PlayerState:
	if !player.is_on_floor():
		return fall
		
	if player.direction == 0 and player.velocity == Vector2.ZERO:
		return idle
	
	if player.jump_requested and player.can_jump():
		return jump
	
	if player.dash_requested:
		return dash
	
	return null

func physics(_delta : float) -> void:
	player.update_x_velocity()
