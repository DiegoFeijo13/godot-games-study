class_name PlayerStateIdle extends PlayerState

const ANIM_NAME = "idle"

@export var walk: PlayerStateWalk

func enter() -> void:
	player.update_animation(ANIM_NAME)	
	
func exit() -> void:
	pass

func process(_delta : float) -> PlayerState:
	if player.direction != Vector2.ZERO:
		return walk
		
	player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	player.velocity.y = move_toward(player.velocity.y, 0, player.SPEED)
	return null
