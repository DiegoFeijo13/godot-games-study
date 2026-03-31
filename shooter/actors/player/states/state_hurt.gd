class_name PlayerStateHurt extends PlayerState

const ANIM_NAME = "hurt"

@export var invulnerable_time : float = 0.6

@onready var hit_box: HitBox = $"../../HitBox"
@onready var idle: PlayerStateIdle = $"../Idle"

var _i_frames : float

func _ready() -> void:
	hit_box.damaged.connect(_on_take_damage)

func init() -> void:
	pass

func enter() -> void:
	player.update_animation(ANIM_NAME)
	_i_frames = invulnerable_time

func exit() -> void:
	pass

func process(_delta : float) -> PlayerState:
	_i_frames -= _delta
	if _i_frames <= 0:
		return idle
	return null

func physics(_delta : float) -> PlayerState:
	return null

func _on_take_damage(_hurt_box : HurtBox) -> void:
	if state_machine.current_state == self:
		return
	state_machine.change_state(self)
	player.take_damage(_hurt_box)
