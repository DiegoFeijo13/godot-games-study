class_name EnemyStateIdle extends EnemyState

const ANIM_NAME : String = "idle"

@export_category("AI")
@export var state_duration_min : float = 0.5
@export var state_duration_max : float = 1.5

@onready var wander: EnemyStateWander = $"../Wander"

var _timer : float = 0.0

func init() -> void:
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
