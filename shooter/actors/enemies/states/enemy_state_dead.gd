class_name EnemyStateDead extends EnemyState

const ANIM_NAME = "dead"

@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

var _damage_position : Vector2
var _direction : Vector2

func enter() -> void:
	enemy.invulnerable = true
	_direction = enemy.global_position.direction_to(_damage_position)
	enemy.set_direction(_direction)
	enemy.velocity = _direction * -knockback_speed	
	enemy.play_animation(ANIM_NAME)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	_disable_hurt_box()

func process(_delta : float) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null

func _disable_hurt_box() -> void:
	var hurt_box : HurtBox = enemy.get_node_or_null("HurtBox")	
	if hurt_box:
		hurt_box.monitoring = false

func _on_animation_finished(_a : String) -> void:
	enemy.queue_free()
