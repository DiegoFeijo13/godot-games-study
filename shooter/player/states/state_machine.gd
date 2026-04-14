class_name PlayerStateMachine extends Node2D

var states : Array[PlayerState]
var prev_state : PlayerState
var current_state : PlayerState
var next_state : PlayerState
var player : Player

@onready var idle: PlayerStateIdle = $Idle
@onready var walk: PlayerStateWalk = $Walk
@onready var hurt: PlayerStateHurt = $Hurt

@onready var hit_box: HitBox = $"../HitBox"

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
	change_state( current_state.process(delta))

func _physics_process(delta: float) -> void:
	change_state( current_state.physics(delta))

func initialize( _player : Player ) -> void:
	states = [
		idle,
		walk,
		hurt
	]		
	
	player = _player
	
	hit_box.damaged.connect(_on_take_damage)
	
	for state in states:
		state.player = _player
		state.init()
	
	change_state( states[0] )
	process_mode = Node.PROCESS_MODE_INHERIT

func change_state(new_state : PlayerState) -> void:
	if new_state == null || new_state == current_state:
		return
	
	next_state = new_state
	
	if current_state:
		current_state.exit()
		
	prev_state = current_state
	current_state = new_state
	current_state.enter()

func _on_take_damage(_hurt_box : HurtBox) -> void:
	if current_state == hurt:
		return
	hurt.damage_position = _hurt_box.global_position
	change_state(hurt)
	player.update_hp(-_hurt_box.damage)
