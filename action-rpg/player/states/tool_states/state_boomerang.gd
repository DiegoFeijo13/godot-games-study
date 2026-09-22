class_name PlayerStateBoomerang extends PlayerState

const BOOMERANG = preload("uid://bn61n55r1pepg")

@onready var idle: PlayerStateIdle = $"../Idle"

var boomerang_instance : Boomerang = null
var throw : bool = false

func enter() -> void:
	if boomerang_instance != null:
		return
	
	var _b := BOOMERANG.instantiate() as Boomerang
	player.add_sibling(_b)
	_b.global_position = player.global_position
	
	var throw_direction := player.direction
	if throw_direction == Vector2.ZERO:
		throw_direction = player.cardinal_direction
	
	_b.throw(throw_direction)
	boomerang_instance = _b
	throw = true

func exit() -> void:
	pass

func process(_delta : float) -> PlayerState:
	if throw:
		return idle
	return null

func handle_input(_event: InputEvent, _action_state : PlayerState) -> PlayerState:
	return null
