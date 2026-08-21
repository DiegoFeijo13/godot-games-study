class_name EnemyStateMachine extends Node2D

var prev_state : EnemyState
var current_state : EnemyState
var enemy : Enemy

@onready var idle: EnemyStateIdle = $Idle
@onready var wander: EnemyStateWander = $Wander
@onready var stun: EnemyStateStun = $Stun
@onready var destroy: EnemyStateDestroy = $Destroy

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED	

func _process(delta: float) -> void:
	change_state( current_state.process(delta))

func _physics_process(delta: float) -> void:
	change_state( current_state.physics(delta))
	
func initialize( _enemy : Enemy ) -> void:	
	var states = [
		idle,
		wander,
		stun,
		destroy
	]		
	
	enemy = _enemy
	
	for state in states:
		state.enemy = _enemy
		state.state_machine = self
		state.init()
	
	change_state( states[0] )
	process_mode = Node.PROCESS_MODE_INHERIT

func change_state(new_state : EnemyState) -> void:
	if new_state == null || new_state == current_state:
		return
	
	if current_state:
		current_state.exit()
		
	prev_state = current_state
	current_state = new_state
	current_state.enter()
