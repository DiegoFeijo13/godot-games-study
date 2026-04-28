class_name PlayerStateJump extends PlayerState

const ANIM_NAME = "jump"

@onready var idle: PlayerStateIdle = $"../Idle"
@onready var walk: PlayerStateWalk = $"../Walk"

func enter() -> void:
	#player.update_animation(ANIM_NAME)		
	player.velocity.y = player.JUMP_VELOCITY
	player.jump_requested = false	
	pass
	
func exit() -> void:
	pass

func process(_delta : float) -> PlayerState:
	if player.is_on_floor():
		if player.direction == 0:
			return idle
		return walk
	
	return null

func physics(_delta : float) -> void:
	_apply_gravity(_delta, _select_gravity_multiplier())

func _select_gravity_multiplier() -> float:
	if player.velocity.y < 0:
		if player.is_holding_jump():
			return 1.0
		# jump was cut
		return player.JUMP_CUT
	# is falling
	return player.FALL

func _apply_gravity(_delta : float, _multiplier : float) -> void:
	player.velocity.y = minf(player.velocity.y + (player.get_gravity().y * _multiplier * _delta), player.FALL_VELOCITY)
