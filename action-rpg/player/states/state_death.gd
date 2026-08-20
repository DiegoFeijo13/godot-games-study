class_name PlayerStateDeath extends PlayerState

const ANIM_NAME = "death/default"

func enter() -> void:
	player.animation_player.play(ANIM_NAME)	
	
func exit() -> void:
	pass

func process(_delta : float) -> PlayerState:
	player.velocity = Vector2.ZERO
	return null

func handle_input(_event: InputEvent, _action_state : PlayerState) -> PlayerState:
	return null
