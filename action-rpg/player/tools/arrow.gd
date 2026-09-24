class_name Arrow extends CharacterBody2D

var direction : Vector2

@export var max_speed : float = 200.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var hurtbox: HurtBox = $Hurtbox

func _ready() -> void:
	visible = false	

func _physics_process(_delta: float) -> void:
	if move_and_slide():
		queue_free()

func throw( _direction : Vector2 ) -> void:
	direction = _direction
	velocity = direction * max_speed
	play_animation()
	visible = true

func play_animation() -> void:
	if direction == Vector2.UP:
		animation_player.play("up_throw")
	elif direction == Vector2.DOWN:
		animation_player.play("down_throw")
	elif direction == Vector2.LEFT:
		animation_player.play("left_throw")
	else:
		animation_player.play("right_throw")

func _on_hurtbox_did_damage() -> void:
	queue_free()

func _on_timer_timeout() -> void:
	queue_free()
