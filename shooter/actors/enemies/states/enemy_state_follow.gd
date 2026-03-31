class_name EnemyStateFollow extends EnemyState

const ANIM_NAME = "follow"

@export var aggro_speed : float = 170.0

@onready var wander: EnemyStateWander = $"../Wander"

func enter() -> void:	
	enemy.set_speed(aggro_speed)
	enemy.play_animation(ANIM_NAME)

func exit() -> void:	
	enemy.reset_speed()
	pass

func process(_delta : float) -> EnemyState:
	var direction = (GlobalGameState.player.global_position - enemy.global_position).normalized()
	
	enemy.set_direction(direction)
	
	return null
