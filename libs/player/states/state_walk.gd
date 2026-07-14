class_name PlayerStateWalk extends PlayerState

const ANIM_NAME = "walk"

@export var idle: PlayerStateIdle

func enter() -> void:
	player.update_animation(ANIM_NAME)
	pass
	
func exit() -> void:
	pass

func process(_delta : float) -> PlayerState:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * player.get_speed()
	return null
