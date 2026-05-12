class_name PlayerStateWallJump extends PlayerState

const ANIM_NAME = "wall_jump"

@onready var idle: PlayerStateIdle = $"../Idle"
@onready var walk: PlayerStateWalk = $"../Walk"
@onready var dash: PlayerStateDash = $"../Dash"
@onready var wall_slide: PlayerStateWallSlide = $"../WallSlide"

func enter() -> void:
	#player.update_animation(ANIM_NAME)		
	player.velocity.y = player.WALL_JUMP_VELOCITY
	player.velocity.x = player.WALL_JUMP_X_FORCE * player.direction * -1
	player.jump_requested = false	
	pass
	
func exit() -> void:
	pass

func process(_delta : float) -> PlayerState:	
	if player.is_on_floor():
		if player.direction == 0:
			return idle
		return walk
	
	if (player.is_touching_left_wall or player.is_touching_right_wall) and player.velocity.y > 0:
		return wall_slide
	
	if player.dash_requested:
		return dash
	
	return null

func physics(_delta : float) -> void:
	_apply_gravity(_delta, _select_gravity_multiplier())

func _select_gravity_multiplier() -> float:
	if player.velocity.y < 0:
		if player.is_holding_jump():
			if player.velocity.y > -50:
				return player.JUMP_APEX_X
			return 1.0
		# jump was cut
		return player.JUMP_CUT
	# is falling
	return player.FALL

func _apply_gravity(_delta : float, _multiplier : float) -> void:
	player.velocity.y = minf(player.velocity.y + (player.get_gravity().y * _multiplier * _delta), player.FALL_VELOCITY)
