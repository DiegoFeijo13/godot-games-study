class_name PlayerStateWalk extends PlayerState

const ANIM_NAME = "walk"


@onready var idle: PlayerStateIdle = $"../Idle"
@onready var jump: PlayerStateJump = $"../Jump"

func enter() -> void:
	player.update_animation(ANIM_NAME)
	pass
	
func exit() -> void:
	pass

func process(_delta : float) -> PlayerState:
	if player.direction == 0 and player.velocity == Vector2.ZERO:
		return idle
	
	if player.jump_requested and player.can_jump():
		return jump
	return null

func physics(_delta : float) -> void:
	player.update_velocity()
	
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * _delta
