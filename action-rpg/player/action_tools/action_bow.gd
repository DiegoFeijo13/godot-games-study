class_name PlayerActionBow extends Node2D

const ARROW = preload("uid://ngr3y74kxbh7")

var arrow_instance : Arrow = null

func act() -> void:
	if arrow_instance != null:
		return
		
	var player := GlobalPlayerManager.player
	
	var _arrow := ARROW.instantiate() as Arrow
	player.add_sibling(_arrow)
	_arrow.global_position = player.global_position
	
	var throw_direction := player.cardinal_direction	
	if throw_direction == Vector2.ZERO:
		throw_direction = Vector2.LEFT
		
	_arrow.throw(throw_direction)
	arrow_instance = _arrow
	
