class_name PlayerStateHurt extends PlayerState

const ANIM_NAME = "hurt"
const INVULNERABLE_TIME : float = 0.6
const KNOCKBACK_SPEED : float = 250.0


@onready var idle: PlayerStateIdle = $"../Idle"


var _i_frames : float
var damage_position : Vector2

func init() -> void:
	pass

func enter() -> void:
	player.set_invulnerable(true)
	var knockback_dir = player.global_position.direction_to(damage_position)
	player.direction = knockback_dir.normalized()
	player.velocity = player.direction * -KNOCKBACK_SPEED
	#player.update_animation(ANIM_NAME)
	_i_frames = INVULNERABLE_TIME

func exit() -> void:
	player.set_invulnerable(false)
	pass

func process(_delta : float) -> PlayerState:
	_i_frames -= _delta
	if _i_frames <= 0:
		return idle
	return null

func handle_input(_event: InputEvent) -> PlayerState:
	return null
