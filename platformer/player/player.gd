class_name Player extends CharacterBody2D

const SPEED : float = 175.0
const JUMP_VELOCITY : float = -400.0
const WALL_JUMP_VELOCITY : float = -475.0
const WALL_JUMP_X_FORCE : float = 275.0
const FALL_VELOCITY : float = 450.0
const COYOTE_TIME : float = 0.1
const JUMP_BUFFER_TIME : float = 0.2
const JUMP_APEX_X : float = 0.4
const JUMP_CUT : float = 4.5
const ACCELERATION : float = 6.0
const DECELERATION : float = 12.0
const AIR_ACCELERATION : float = 4.0
const AIR_DECELERATION : float = 8.0
const FALL : float = 3.0
const DASH_COOLDOWN : float = 0.3

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
var dash_requested : bool
var touched_floor_after_dash_request : bool = false
var current_dash_cooldown : float = 0

func _ready() -> void:
	state_machine.initialize(self)
	GlobalEventBus.player_loaded.emit(self)

func _process(_delta: float) -> void:
	if current_dash_cooldown > 0:
		current_dash_cooldown -= _delta
	
	if is_on_floor():
		current_coyote_time = COYOTE_TIME
		touched_floor_after_dash_request = true
	else:
		current_coyote_time = maxf(0, current_coyote_time - _delta)
		current_jump_buffer_time = maxf(0, current_jump_buffer_time - _delta)

func _physics_process(_d: float) -> void:
	if current_jump_buffer_time <= 0:
		jump_requested = false
	
	if Input.is_action_just_pressed("jump"):
		current_jump_buffer_time = JUMP_BUFFER_TIME
		jump_requested = true
	
	if Input.is_action_just_pressed("dash") and can_dash():
		dash_requested = true
		touched_floor_after_dash_request = false
	
	direction = Input.get_axis("left", "right")
	if direction != 0:
		looking_direction = direction
	
	is_touching_left_wall = ray_cast_left.is_colliding() and direction < 0
	is_touching_right_wall = ray_cast_right.is_colliding() and direction > 0
		
	sprite_2d.flip_h = looking_direction > 0
	
	state_machine.physics(_d)
	move_and_slide()

func update_x_velocity() -> void:
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

func is_touching_wall() -> bool:
	return is_touching_left_wall or is_touching_right_wall

func start_dash_cooldown() -> void:
	current_dash_cooldown = DASH_COOLDOWN

func can_dash() -> bool: 
	return current_dash_cooldown <= 0 and dash_requested == false and touched_floor_after_dash_request == true
