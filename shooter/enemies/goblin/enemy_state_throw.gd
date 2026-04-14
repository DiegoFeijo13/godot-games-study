class_name EnemyStateThrow extends EnemyState

const ANIM_NAME = "idle"
const COOLDOWN_MAX :float = 0.90
const COOLDOWN_MIN :float = 0.60
const BULLET_SPEED : float = 700.0
const KNIFE = preload("uid://cosi1b8d2b71w")

@export var damage: int = 1
@export var projectiles: int = 1

var _current_cooldown : float

func enter() -> void:
	enemy.play_animation(ANIM_NAME)
	enemy.set_speed(0.0)
	_look_to_player()

func exit() -> void:
	enemy.reset_speed()

func process(_d: float) -> EnemyState:
	if _current_cooldown > 0.0:
		_current_cooldown -= _d
	else:
		_shoot()
	
	return null

func _shoot() -> void:	
	if _current_cooldown > 0.0:
		return
	
	_current_cooldown = randf_range(COOLDOWN_MIN, COOLDOWN_MAX)	
	var direction := (GlobalPlayerManager.get_player_global_position() - enemy.global_position)
	var knife: = KNIFE.instantiate() as Bullet
	knife.direction = direction.normalized()
	knife.position = enemy.position
	knife.speed = BULLET_SPEED
	knife.damage = damage
	enemy.get_parent().add_child(knife)

func _look_to_player() -> void:	
	var next_dir = (GlobalPlayerManager.get_player_global_position() - enemy.global_position)	
	enemy.set_direction(next_dir.normalized())
