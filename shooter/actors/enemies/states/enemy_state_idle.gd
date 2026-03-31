class_name EnemyStateIdle extends EnemyState

const ANIM_NAME = "idle"

@onready var walk: EnemyState = $"../Walk"

func enter() -> void:
	pass
	
func exit() -> void:
	pass

func process(_delta : float) -> EnemyState:
	if enemy.direction != Vector2.ZERO:
		return walk
		
	enemy.velocity.x = move_toward(enemy.velocity.x, 0, enemy.speed)
	enemy.velocity.y = move_toward(enemy.velocity.y, 0, enemy.speed)
	return null
