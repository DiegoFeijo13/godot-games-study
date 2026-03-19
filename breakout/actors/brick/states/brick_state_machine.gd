class_name BrickStateMachine extends Node2D

var states : Array[BrickState]
var prev_state : BrickState
var current_state : BrickState

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(_delta: float) -> void:	
	change_state(current_state.process(_delta))

func initialize(_brick: Brick) -> void:
	states = []
	for c in get_children():
		if c is BrickState:
			states.append(c)
	
	for s in states:
		s.brick = _brick
		s.state_machine = self
		s.init()
	
	if states.size() > 0:
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

func change_state(new_state : BrickState) -> void:
	if new_state == null || new_state == current_state:
		return
	
	if current_state:
		current_state.exit()
	
	prev_state = current_state
	current_state = new_state
	current_state.enter()
