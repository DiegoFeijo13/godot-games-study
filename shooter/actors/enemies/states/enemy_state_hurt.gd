class_name EnemyStateHurt extends EnemyState

const ANIM_NAME = "hurt"

@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@onready var wander: EnemyStateWander = $"../Wander"

var damage_position : Vector2
var _direction : Vector2
var _animation_finished : bool = false

func enter() -> void:
	enemy.invulnerable = true
	_animation_finished = false
	_direction = enemy.global_position.direction_to(damage_position)
	enemy.set_direction(_direction)
	enemy.velocity = _direction * -knockback_speed
	enemy.play_animation(ANIM_NAME)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	
func exit() -> void:
	enemy.invulnerable = false
	enemy.animation_player.animation_finished.disconnect(_on_animation_finished)
	pass

func process(_delta : float) -> EnemyState:
	if _animation_finished:
		return wander
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta	
	return null

func _on_animation_finished(_a : String) -> void:
	_animation_finished = true
