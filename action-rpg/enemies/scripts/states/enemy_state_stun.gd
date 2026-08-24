class_name EnemyStateStun extends EnemyState

const ANIM_NAME : String = "stun"

@onready var idle: EnemyStateIdle = $"../Idle"

var animation_finished : bool = false
var direction : Vector2
var damage_position : Vector2
var knockback_speed : float
var decelerate_speed : float

func init() -> void:
	enemy.enemy_damaged.connect(_on_enemy_damaged)
	knockback_speed = enemy.enemy_data.stun_knockback_speed
	decelerate_speed = enemy.enemy_data.stun_decelerate_speed
	pass

func enter() -> void:
	animation_finished = false
	enemy.invulnerable = true
	
	direction = enemy.global_position.direction_to(damage_position)
	
	enemy.set_direction(direction)
	enemy.velocity = direction * -knockback_speed
	enemy.update_animation(ANIM_NAME)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)

func exit() -> void:
	enemy.invulnerable = false
	enemy.animation_player.animation_finished.disconnect(_on_animation_finished)

func process(_delta : float) -> EnemyState:
	if animation_finished:
		return idle
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null

func _on_enemy_damaged(_h : HurtBox) -> void:
	damage_position = _h.global_position
	state_machine.change_state(self)

func _on_animation_finished(_a : String) -> void:
	animation_finished = true
