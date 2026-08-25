class_name EnemyStateShoot extends EnemyState

const ANIM_NAME : String = "idle"
const BULLET : Resource = preload("uid://de4c52phuqhsb")

@export var vision_area : VisionArea
@onready var idle: EnemyStateIdle = $"../Idle"

var chance_of_shooting : float

func init() -> void:
	if vision_area:
		vision_area.player_entered.connect(_on_player_enter)
		vision_area.player_exited.connect(_on_player_exited)
	pass
	
	chance_of_shooting = enemy.enemy_data.chance_of_attacking

func enter() -> void:	
	enemy.update_animation(ANIM_NAME)
	enemy.velocity = Vector2.ZERO

func exit() -> void:
	pass

func process(_delta : float) -> EnemyState:
	print("current cooldown: ", enemy._current_attack_cooldown)	
	if enemy._current_attack_cooldown > 0:
		return idle
	
	var x = randf()
	print("chance of shooting: ", x, " ref: ", chance_of_shooting)
	if x > chance_of_shooting:
		return idle	
	
	# shoot projectile
	var bullet: = BULLET.instantiate() as Bullet
	bullet.direction = enemy.cardinal_direction.normalized()
	bullet.position = enemy.position
	bullet.speed = enemy.enemy_data.bullet_speed
	bullet.damage = enemy.enemy_data.bullet_damage
	enemy.get_parent().add_child(bullet)
	# start cooldown
	enemy.start_cooldown()
	
	return idle

func physics(_delta : float) -> EnemyState:
	return null

func _on_player_enter() -> void:
	state_machine.change_state( self )	

func _on_player_exited() -> void:
	pass
