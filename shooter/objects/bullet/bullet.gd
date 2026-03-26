class_name Bullet extends CharacterBody2D

const SPEED : float = 700.0
const LIFETIME : float = 0.8
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var direction : Vector2
var _current_lifetime : float

func _ready() -> void:
	animation_player.play("moving")
	_current_lifetime = LIFETIME

func _process(_d: float) -> void:
	_current_lifetime -= _d
	if _current_lifetime <= 0:
		queue_free()

func _physics_process(_d: float) -> void:
	velocity = direction * SPEED
	
	if move_and_slide():
		queue_free()

func _on_area_2d_area_entered(_a: Area2D) -> void:
	print(_a)
