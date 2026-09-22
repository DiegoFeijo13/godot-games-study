class_name Boomerang extends Node2D

enum State { INACTIVE, THROW, RETURN }

var direction : Vector2
var speed : float = 0
var state : State

@export var acceleration : float = 250.0
@export var max_speed : float = 175.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	visible = false
	state = State.INACTIVE

func _physics_process(delta: float) -> void:
	if state == State.THROW:
		speed -= acceleration * delta
		position += direction * speed * delta
		if speed <= 0:
			state = State.RETURN
		
	elif state == State.RETURN:
		direction = global_position.direction_to(GlobalPlayerManager.player.global_position)
		speed += acceleration * delta
		position += direction * speed * delta		
		if global_position.distance_to(GlobalPlayerManager.player.global_position) <= 10:
			queue_free()	
	
	var speed_ratio := speed / max_speed
	audio.pitch_scale = speed_ratio * 0.75 + 0.75
	animation_player.speed_scale = 1 + (speed_ratio * 0.25)

func throw( _direction : Vector2 ) -> void:
	direction = _direction
	speed = max_speed
	state = State.THROW
	animation_player.play("boomerang")
	visible = true
