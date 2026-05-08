class_name PlayerStateIdle extends PlayerState

const ANIM_NAME = "idle"

@onready var walk: PlayerStateWalk = $"../Walk"
@onready var jump: PlayerStateJump = $"../Jump"

func enter() -> void:
	player.update_animation(ANIM_NAME)	
	
func exit() -> void:
	pass

func process(_delta : float) -> PlayerState:
	if player.direction != 0:
		return walk
	
	if player.jump_requested and player.can_jump():
		return jump
	return null

func physics(_delta : float) -> void:
	if not player.is_on_floor():
		player.fall(_delta)
