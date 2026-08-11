class_name PlayerStateWalk extends PlayerState

const ANIM_NAME = "walk"

@onready var idle: PlayerStateIdle = $"../Idle"
@onready var attack: PlayerStateAttack = $"../Attack"

func enter() -> void:
	player.update_animation(ANIM_NAME)
	pass
	
func exit() -> void:
	pass

func process(_delta : float) -> PlayerState:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * player.get_speed()
	
	if player.set_direction():
		player.update_animation(ANIM_NAME)
		
	return null

func handle_input(_event: InputEvent) -> PlayerState:
	if _event.is_action_pressed("action"):
		return attack
	return null
