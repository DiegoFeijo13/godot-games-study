class_name Paddle extends CharacterBody2D

const SPEED = 300.0

func _ready() -> void:
	GlobalGameState.paddle = self

func _physics_process(_delta: float) -> void:	
	var direction := Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, _delta * SPEED)

	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("action"):
		GlobalEventBus.action_pressed.emit()
