class_name EnemyStateDead extends EnemyState

const ANIM_NAME = "dead"
const DROP = preload("uid://plobpwiyrycq")

@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("Item Drops")
@export var drops : Array [DropData]

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
	_drop_items()

func process(_delta : float) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null

func _disable_hurt_box() -> void:
	var hurt_box : HurtBox = enemy.get_node_or_null("HurtBox")	
	if hurt_box:
		hurt_box.monitoring = false

func _on_animation_finished(_a : String) -> void:
	enemy.queue_free()

func _drop_items() -> void:
	if drops.size() == 0:
		return
	
	for i in drops.size():
		if drops[i] == null or drops[i].item == null:
			continue
		var drop_count := drops[i].get_drop_count()
		for j in drop_count:
			var drop : Drop = DROP.instantiate() as Drop
			drop.item_data = drops[i].item
			drop.global_position = enemy.global_position
			drop.velocity = enemy.velocity.rotated( randf_range(-1.5, 1.5)) * randf_range(0.9, 1.5)
			enemy.get_parent().get_parent().call_deferred("add_child", drop)
