class_name Player extends CharacterBody2D

const SPEED : float = 175.0
const JUMP_VELOCITY : float = -400.0
const FALL_VELOCITY : float = 450.0
const COYOTE_TIME : float = 0.1
const JUMP_BUFFER_TIME : float = 0.2
const JUMP_APEX_X : float = 0.4
const ACCELERATION : float = 6.0
const DECELERATION : float = 12.0
const AIR_ACCELERATION : float = 4.0
const AIR_DECELERATION : float = 8.0
const FALL : float = 3.0
const JUMP_CUT : float = 4.5

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight

var direction : float
var looking_direction : float

var jump_requested : bool
var current_coyote_time : float = 0.0
var current_jump_buffer_time : float = 0.0
var is_touching_left_wall : bool = false
var is_touching_right_wall : bool = false

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
	
	is_touching_left_wall = ray_cast_left.is_colliding() and direction < 0
	is_touching_right_wall = ray_cast_right.is_colliding() and direction > 0
		
	sprite_2d.flip_h = looking_direction > 0	
	
	update_velocity()
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

func fall(_delta: float) -> void:
	velocity.y = minf(velocity.y + (get_gravity().y * FALL * _delta), FALL_VELOCITY)
