class_name PlayerStateHurt extends PlayerState

const ANIM_NAME = "hurt"
const KNOCKBACK_SPEED : float = 250.0
const DECELERATE_SPEED : float = 10.0

@onready var idle: PlayerStateIdle = $"../Idle"

var animation_finished : bool = false

func init() -> void:
	pass

func enter() -> void:
	player.effect_animation_player.animation_finished.connect(_on_animation_finished)
	player.make_invulnerable()
	var knockback_dir = player.global_position.direction_to(player.damage_position)
	player.direction = knockback_dir.normalized()
	player.velocity = player.direction * -KNOCKBACK_SPEED
	player.update_animation(ANIM_NAME)
	player.effect_animation_player.play("damaged")

func exit() -> void:
	player.effect_animation_player.animation_finished.disconnect(_on_animation_finished)
	animation_finished = false

func process(_delta : float) -> PlayerState:
	player.velocity -= player.velocity * DECELERATE_SPEED * _delta
	if animation_finished:
		return idle
	return null

func handle_input(_event: InputEvent, _action_state : PlayerState) -> PlayerState:
	return null

func _on_animation_finished(_a : String) -> void:
	animation_finished = true
