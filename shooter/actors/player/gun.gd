class_name Gun extends Node2D

const BULLET = preload("uid://b3taluwpnqkb")
const COOLDOWN :float = 0.3

@onready var player: Player = $".."

var _current_cooldown : float

func _process(_d: float) -> void:
	if _current_cooldown > 0.0:		
		_current_cooldown -= _d

func _unhandled_input(_e: InputEvent) -> void:
	if Input.is_action_pressed("shoot"):
		_shoot()

func _shoot() -> void:	
	if _current_cooldown > 0.0:
		return
	
	_current_cooldown = COOLDOWN
	var camera = get_viewport().get_camera_2d()	
	var direction : Vector2 = camera.get_global_mouse_position() - player.global_position
	var bullet: = BULLET.instantiate() as Bullet
	bullet.direction = direction.normalized()
	bullet.position = player.position
	player.get_parent().add_child(bullet)
