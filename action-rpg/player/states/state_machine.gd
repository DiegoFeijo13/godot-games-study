class_name PlayerStateMachine extends Node2D

var prev_state : PlayerState
var current_state : PlayerState
var next_state : PlayerState
var player : Player

@onready var idle: PlayerStateIdle = $Idle
@onready var walk: PlayerStateWalk = $Walk
@onready var attack: PlayerStateAttack = $Attack
@onready var hurt: PlayerStateHurt = $Hurt

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	GlobalEventBus.player_take_damage.connect(_on_player_take_damage)

func _process(delta: float) -> void:
	change_state( current_state.process(delta))

func _physics_process(delta: float) -> void:
	change_state( current_state.physics(delta))

func _unhandled_input(event: InputEvent) -> void:
	var action_state : PlayerState = null
	if event.is_action_pressed("action"):
		action_state = on_action_pressed()
	change_state(current_state.handle_input(event, action_state))
	
func initialize( _player : Player ) -> void:
	var states = [
		idle,
		walk,
		attack,
		hurt
	]		
	
	player = _player
	
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

func _on_player_take_damage(_value : int) -> void:
	change_state(hurt)

func on_action_pressed() -> PlayerState:
	# Checks what is equiped in action
	var equip = GlobalPlayerManager.inventory.action_one_equip
	if equip == null:
		return null
	return _resolve_state_by_name(equip.item_data.player_state_name)
	
	
func _resolve_state_by_name(state_name : String) -> PlayerState:
	match(state_name):
		"idle":		
			return idle
		"walk":
			return walk
		"attack":
			return attack
		"hurt":
			return hurt
	return null
