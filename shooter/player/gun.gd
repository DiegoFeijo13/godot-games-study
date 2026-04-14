class_name Gun extends Node2D

const BULLET = preload("uid://b3taluwpnqkb")
const COOLDOWN_MAX :float = 0.60
const COOLDOWN_MIN :float = 0.15
const BULLET_SPEED : float = 700.0
const BULLET_DMG : int = 1
const BULLET_MAX_DMG : int = 10

@onready var player: Player = $".."

var cooldown_mod : float
var _current_cooldown : float

func _process(_d: float) -> void:
	if _current_cooldown > 0.0:		
		_current_cooldown -= _d

func shoot() -> void:	
	if _current_cooldown > 0.0:
		return
	
	_current_cooldown = _calculate_cooldown()
	var camera = get_viewport().get_camera_2d()	
	var direction : Vector2 = camera.get_global_mouse_position() - player.global_position
	var bullet: = BULLET.instantiate() as Bullet
	bullet.direction = direction.normalized()
	bullet.position = player.position
	bullet.speed = BULLET_SPEED
	bullet.damage = _calculate_bullet_damage()
	player.get_parent().add_child(bullet)

func _calculate_cooldown() -> float:
	var cd := COOLDOWN_MAX - (COOLDOWN_MAX * player._fire_rate_mod)
	return clampf(cd, COOLDOWN_MIN, COOLDOWN_MAX)

func _calculate_bullet_damage() -> int:
	var dmg := int(BULLET_DMG * (1 + player._bullet_damage_mod))
	return clampi(dmg, BULLET_DMG, BULLET_MAX_DMG)
	
	
