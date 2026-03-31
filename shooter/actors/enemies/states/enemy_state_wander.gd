class_name EnemyStateWander extends EnemyState

const ANIM_NAME = "wander"

@export var cicle_min : float = 1.0
@export var cicle_max : float = 2.0

var _cicle_timer : float = 0

func enter() -> void:
	_cicle_timer = randf_range(cicle_min, cicle_max)
	_move_to_player()
	enemy.play_animation(ANIM_NAME)
	pass
	
func exit() -> void:
	pass

func process(_delta : float) -> EnemyState:
	_cicle_timer -= _delta
	
	if _cicle_timer <= 0:
		_move_to_player()
		_cicle_timer = randf_range(cicle_min, cicle_max)	
	
	return null

func _move_to_player() -> void:
	var next_dir = (GlobalGameState.player.global_position - enemy.global_position)	
	enemy.set_direction(next_dir.normalized())
