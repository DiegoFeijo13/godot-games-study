class_name EnemyStateMachine extends Node2D

var states : Array[EnemyState]
var prev_state : EnemyState
var current_state : EnemyState
var next_state : EnemyState
var enemy : Enemy

@onready var player_detection: PlayerDetection = $"../PlayerDetection"

# States
@onready var wander: EnemyStateWander = $Wander
@onready var throw: EnemyStateThrow = $Throw
@onready var hurt: EnemyStateHurt = $Hurt
@onready var dead: EnemyStateDead = $Dead

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
	change_state( current_state.process(delta))

func _physics_process(delta: float) -> void:
	change_state( current_state.physics(delta))

func initialize( _enemy : Enemy ) -> void:
	enemy = _enemy
	
	enemy.enemy_damaged.connect(_on_take_damage)
	enemy.enemy_destroyed.connect(_on_enemy_destroyed)
	player_detection.player_entered.connect(_on_player_enter)
	player_detection.player_exited.connect(_on_player_exit)
	
	states = [
		wander,
		throw,
		hurt,
		dead
	]
	
	for s in states:
		s.enemy = _enemy
		s.init()
	
	if states.size() > 0:
		change_state( states[0] )
		process_mode = Node.PROCESS_MODE_INHERIT

func change_state(new_state : EnemyState) -> void:
	if new_state == null || new_state == current_state || current_state == EnemyStateDead:
		return
	
	next_state = new_state
	
	if current_state:
		current_state.exit()
		
	prev_state = current_state
	current_state = new_state
	current_state.enter()

func _on_player_enter() -> void:		
	if current_state is EnemyStateHurt or current_state is EnemyStateDead:
		return
	change_state(throw)

func _on_player_exit() -> void:
	if current_state is EnemyStateHurt or current_state is EnemyStateDead:
		return
	change_state(wander)

func _on_take_damage(_hurt_box : HurtBox) -> void:
	hurt.damage_position = _hurt_box.global_position
	change_state(hurt)

func _on_enemy_destroyed(_h : HurtBox) -> void:
	GlobalEventBus.enemy_died.emit(enemy)
	dead._damage_position = _h.global_position
	change_state(dead)
