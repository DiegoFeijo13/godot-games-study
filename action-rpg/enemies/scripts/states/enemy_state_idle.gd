class_name EnemyStateIdle extends EnemyState

const ANIM_NAME : String = "idle"

@onready var wander: EnemyStateWander = $"../Wander"

var _timer : float = 0.0
var state_duration_min : float
var state_duration_max : float

func init() -> void:
	state_duration_min = enemy.enemy_data.idle_state_duration_min
	state_duration_max = enemy.enemy_data.idle_state_duration_max
	pass

func enter() -> void:
	enemy.update_animation(ANIM_NAME)
	enemy.velocity = Vector2.ZERO
	_timer = randf_range(state_duration_min, state_duration_max)

func exit() -> void:
	pass

func process(_delta : float) -> EnemyState:
	_timer -= _delta
	if _timer <= 0:
		return wander
	return null

func physics(_delta : float) -> EnemyState:
	return null
