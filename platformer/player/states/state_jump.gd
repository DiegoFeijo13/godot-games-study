class_name PlayerStateJump extends PlayerState

const ANIM_NAME = "jump"
const X_GRAVITY : float = 2.0

@onready var idle: PlayerStateIdle = $"../Idle"

func enter() -> void:
	#player.update_animation(ANIM_NAME)		
	player.velocity.y = player.JUMP_VELOCITY
	player.jump_requested = false	
	pass
	
func exit() -> void:
	pass

func process(_delta : float) -> PlayerState:
	if player.is_on_floor():
		return idle
	return null

func physics(_delta : float) -> void:
	if player.velocity.y < 0:
		if player.is_holding_jump():
			_apply_normal_gravity(_delta)
		else:
			_apply_multiplied_gravity(_delta)
	else:
		_apply_normal_gravity(_delta)
	
	player.update_velocity()

func _apply_normal_gravity(_delta : float) -> void:
	player.velocity += player.get_gravity() * _delta

func _apply_multiplied_gravity(_delta : float) -> void:
	player.velocity += player.get_gravity() * X_GRAVITY * _delta
