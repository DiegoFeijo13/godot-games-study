class_name BallStateMachine extends Node2D

var states : Array[BallState]
var prev_state : BallState
var current_state : BallState

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(_delta: float) -> void:	
	change_state(current_state.process(_delta))

func _physics_process(_delta: float) -> void:
	change_state(current_state.physics(_delta))

func initialize(_ball: Ball) -> void:
	states = []
	for c in get_children():
		if c is BallState:
			states.append(c)
	
	for s in states:
		s.ball = _ball
		s.state_machine = self
		s.init()
	
	if states.size() > 0:
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

func change_state(new_state : BallState) -> void:
	if new_state == null || new_state == current_state:
		return
	
	if current_state:
		current_state.exit()
	
	prev_state = current_state
	current_state = new_state
	current_state.enter()
