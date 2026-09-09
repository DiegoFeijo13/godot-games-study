class_name EnemyStateDestroy extends EnemyState

const PICKUP : Resource = preload("uid://c5aqqw3ui6qoh")
const ANIM_NAME : String = "destroy"

var direction : Vector2
var damage_position : Vector2
var knockback_speed : float
var decelerate_speed : float

@onready var hurtbox: HurtBox = $"../../Hurtbox"
@onready var vision_area: VisionArea = $"../../VisionArea"

func init() -> void:
	enemy.enemy_destroyed.connect(_on_enemy_destroyed)
	knockback_speed = enemy.enemy_data.stun_knockback_speed
	decelerate_speed = enemy.enemy_data.stun_decelerate_speed
	pass

func enter() -> void:
	enemy.invulnerable = true	
	direction = enemy.global_position.direction_to(damage_position)	
	enemy.set_direction(direction)
	enemy.velocity = direction * -knockback_speed
	enemy.update_animation(ANIM_NAME)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	hurtbox.monitoring = false
	vision_area.monitoring = false

func exit() -> void:
	pass

func process(_delta : float) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null

func _on_enemy_destroyed(_h : HurtBox) -> void:
	damage_position = _h.global_position
	state_machine.change_state(self)

func _on_animation_finished(_a : String) -> void:
	_drop_items()
	enemy.queue_free()

func _drop_items() -> void:
	if enemy.drop_table == null:
		return
	
	var item_drop_data := enemy.drop_table.get_drop()
	if item_drop_data == null:
		return
	
	print("dropped: ", item_drop_data.name)
	var drop : ItemPickup = PICKUP.instantiate() as ItemPickup
	drop.item_drop_data = item_drop_data
	drop.position = enemy.position
	enemy.call_deferred("add_sibling", drop)
