class_name Player extends CharacterBody2D

const SPEED : float = 175.0
const JUMP_VELOCITY : float = -400.0
const COYOTE_TIME : float = 0.1
const JUMP_BUFFER_TIME : float = 0.2
const ACCELERATION : float = 5.83
const DECELERATION : float = 11.66
const AIR_ACCELERATION : float = 2.91
const AIR_DECELERATION : float = 5.83

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: PlayerStateMachine = $StateMachine

var direction : float
var looking_direction : float

var jump_requested : bool
var current_coyote_time : float = 0.0
var current_jump_buffer_time : float = 0.0

func _ready() -> void:
	state_machine.initialize(self)
	GlobalEventBus.player_loaded.emit(self)

func _process(_delta: float) -> void:
	if is_on_floor():
		current_coyote_time = COYOTE_TIME
	else:
		current_coyote_time = maxf(0, current_coyote_time - _delta)
		current_jump_buffer_time = maxf(0, current_jump_buffer_time - _delta)

func _physics_process(_d: float) -> void:
	if current_jump_buffer_time <= 0:
		jump_requested = false
	
	if Input.is_action_just_pressed("ui_accept"):
		current_jump_buffer_time = JUMP_BUFFER_TIME
		jump_requested = true
	
	direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		looking_direction = direction
	
	sprite_2d.flip_h = looking_direction > 0
	
	state_machine.physics(_d)
	
	move_and_slide()

func update_velocity() -> void:
	var step : float = 0
		
	if direction == 0:
		step = DECELERATION if is_on_floor() else AIR_DECELERATION
	else:
		step = ACCELERATION if is_on_floor() else AIR_ACCELERATION
	
	velocity.x = move_toward(velocity.x, direction * SPEED, step)

func update_animation(anim_name : String) -> void:
	animation_player.play(anim_name)

func get_speed() -> float:
	return SPEED

func can_jump() -> bool:
	return is_on_floor() or current_coyote_time > 0

func is_holding_jump() -> bool:
	return Input.is_action_pressed("ui_accept")
