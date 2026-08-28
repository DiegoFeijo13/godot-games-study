class_name EnemyStateChase extends EnemyState

const PATHFINDER : PackedScene = preload("res://components/pathfinder/pathfinder.tscn")
const ANIM_NAME : String = "walk"

@onready var idle: EnemyStateIdle = $"../Idle"
@onready var vision_area: VisionArea = $"../../VisionArea"
@onready var hurtbox: HurtBox = $"../../Hurtbox"

var _timer : float = 0.0
var _direction : Vector2
var _can_see_player : bool = false
var _pathfinder : Pathfinder
var _turn_rate : float
var _chase_speed : float
var _aggro_duration : float

func init() -> void:
	_turn_rate = enemy.enemy_data.chase_turn_rate
	_chase_speed = enemy.enemy_data.chase_speed
	_aggro_duration = enemy.enemy_data.chase_aggro_duration
	
	if vision_area:
		vision_area.player_entered.connect(_on_player_enter)
		vision_area.player_exited.connect(_on_player_exited)

func enter() -> void:
	_pathfinder = PATHFINDER.instantiate() as Pathfinder
	enemy.add_child(_pathfinder)	
	_timer = enemy.enemy_data.chase_aggro_duration	
	enemy.update_animation(ANIM_NAME)
	
	if hurtbox:
		hurtbox.monitoring = true

func exit() -> void:
	_pathfinder.queue_free()
	if hurtbox:
		hurtbox.monitoring = false
	_can_see_player = false

func process(_delta : float) -> EnemyState:
	_direction = lerp(_direction, _pathfinder.move_dir, _turn_rate)
	enemy.velocity = _direction * _chase_speed
	
	if enemy.set_direction(_direction):
		enemy.update_animation(ANIM_NAME)
	
	if _can_see_player == false:
		_timer -= _delta
		if _timer < 0:
			return idle
	else:
		_timer = _aggro_duration
	return null

func physics(_delta : float) -> EnemyState:
	return null

func _on_player_enter() -> void:
	_can_see_player = true
	state_machine.change_state( self )

func _on_player_exited() -> void:
	_can_see_player = false
