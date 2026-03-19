class_name BallStateAttached extends BallState

@onready var state_moving: BallStateMoving = $"../StateMoving"

func init() -> void:
	ball.global_position.x = GlobalGameState.paddle.global_position.x
	ball.global_position.y = GlobalGameState.paddle.global_position.y - 16
	pass

func enter() -> void:
	GlobalEventBus.action_pressed.connect(_on_action_pressed)
	pass

func exit() -> void:
	GlobalEventBus.action_pressed.disconnect(_on_action_pressed)
	pass

func process(_d : float) -> BallState:
	return null

func physics(_d : float) -> BallState:
	ball.global_position.x = GlobalGameState.paddle.global_position.x
	return null

func _on_action_pressed() -> void:
	state_machine.change_state(state_moving)
