class_name PlayerStateHurt extends PlayerState

const ANIM_NAME = "hurt"

@export var invulnerable_time : float = 0.6
@export var knockback_speed : float = 250.0
@export var idle: PlayerStateIdle

var _i_frames : float
var damage_position : Vector2

func init() -> void:
	pass

func enter() -> void:
	player.update_animation(ANIM_NAME)
	var knockback_dir = player.global_position.direction_to(damage_position)
	player.direction = knockback_dir.normalized()
	player.velocity = player.direction * -knockback_speed
	_i_frames = invulnerable_time

func exit() -> void:
	pass

func process(_delta : float) -> PlayerState:
	_i_frames -= _delta
	if _i_frames <= 0:
		return idle
	return null
