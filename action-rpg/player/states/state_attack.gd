class_name PlayerStateAttack extends PlayerState

const ANIM_NAME = "attack"
const DECELERATE_SPEED : float = 5.0

@onready var idle: PlayerStateIdle = $"../Idle"
@onready var walk: PlayerStateWalk = $"../Walk"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var sword_hurtbox: HurtBox = $"../../Sprite2D/SwordHurtbox"


var attacking : bool = false

func enter() -> void:
	player.update_animation(ANIM_NAME)
	animation_player.animation_finished.connect(on_attack_end)
	attacking = true
	sword_hurtbox.monitoring = true
	await get_tree().create_timer(0.075).timeout
	pass
	
func exit() -> void:
	animation_player.animation_finished.disconnect(on_attack_end)
	attacking = false
	sword_hurtbox.monitoring = false
	pass

func process(_delta : float) -> PlayerState:
	player.velocity -= player.velocity * DECELERATE_SPEED * _delta
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		return walk
	return null

func handle_input(_event: InputEvent, _action_state : PlayerState) -> PlayerState:
	return null
	
func on_attack_end(_a : String) -> void:
	attacking = false
