class_name PlayerActionBoomerang extends Node2D

const BOOMERANG = preload("uid://bn61n55r1pepg")

var boomerang_instance : Boomerang = null

func act() -> void:
	if boomerang_instance != null:
		return
		
	var player := GlobalPlayerManager.player
	
	var _b := BOOMERANG.instantiate() as Boomerang
	player.add_sibling(_b)
	_b.global_position = player.global_position
	
	var throw_direction := player.direction
	if throw_direction == Vector2.ZERO:
		throw_direction = player.cardinal_direction
	# if still zero
	if throw_direction == Vector2.ZERO:
		throw_direction = Vector2.LEFT
	
	_b.throw(throw_direction)
	boomerang_instance = _b
	
