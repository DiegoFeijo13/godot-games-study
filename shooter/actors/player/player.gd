class_name Player extends CharacterBody2D

const SPEED = 300.0
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: PlayerStateMachine = $StateMachine

var direction : Vector2

func _ready() -> void:
	state_machine.initialize(self)

func _process(_delta: float) -> void:
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()

func _physics_process(_d: float) -> void:	
	move_and_slide()

func update_animation(anim_name : String) -> void:
	animation_player.play(anim_name)

func set_direction() -> void:
	if direction == Vector2.ZERO:
		return
	
	#todo : flip player according to mouse coursor
	sprite_2d.flip_h = direction.x >= 0
