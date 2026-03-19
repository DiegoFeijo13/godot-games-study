class_name Ball extends CharacterBody2D

@onready var ball_state_machine: BallStateMachine = $BallStateMachine

func _ready() -> void:
	ball_state_machine.initialize(self)
