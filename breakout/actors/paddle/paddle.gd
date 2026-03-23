class_name Paddle extends CharacterBody2D

const SPEED = 300.0
var _start_pos : Vector2

func _ready() -> void:
	GlobalGameState.paddle = self
	GlobalEventBus.next_round.connect(_on_next_round)
	_start_pos = global_position

func _physics_process(_delta: float) -> void:
	if GlobalGameState.is_paused || GlobalGameState.is_game_over:
		return
	
	var direction := Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, _delta * SPEED)

	move_and_slide()

func _on_next_round() -> void:
	global_position = _start_pos

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("start"):
		GlobalEventBus.pause_pressed.emit()
	
	if GlobalGameState.is_paused == false && GlobalGameState.is_game_over == false:
		if event.is_action_pressed("action"):
			GlobalEventBus.action_pressed.emit()
		if event.is_action_pressed("cancel"):
			GlobalEventBus.next_round.emit()
	
