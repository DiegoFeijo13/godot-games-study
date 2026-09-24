class_name EnemyStateWander extends EnemyState

const ANIM_NAME : String = "walk"

@onready var idle: EnemyStateIdle = $"../Idle"

var _timer : float = 0.0
var _direction : Vector2
var wander_speed : float
var state_animation_duration : float
var state_cycles_min : int
var state_cycles_max : int

func init() -> void:
	wander_speed = enemy.enemy_data.wander_speed
	state_animation_duration = enemy.enemy_data.wander_state_animation_duration
	state_cycles_min = enemy.enemy_data.wander_state_cycles_min
	state_cycles_max = enemy.enemy_data.wander_state_cycles_max
	pass

func enter() -> void:
	_timer = randi_range( state_cycles_min, state_cycles_max ) * state_animation_duration
	var rand : int = randi_range(0,3)
	_direction = GlobalConstants.DIR_4[rand]
	enemy.velocity = _direction * wander_speed
	enemy.set_direction(_direction)
	enemy.update_animation(ANIM_NAME)
	
func exit() -> void:
	pass

func process(_delta : float) -> EnemyState:
	_timer -= _delta
	if _timer <= 0:
		return idle
	return null

func physics(_delta : float) -> EnemyState:
	return null
