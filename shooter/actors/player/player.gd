class_name Player extends CharacterBody2D

const SPEED = 300.0

@export var hp : float = 3.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: PlayerStateMachine = $StateMachine

var direction : Vector2

var _current_hp : float

func _ready() -> void:
	GlobalGameState.player = self
	state_machine.initialize(self)
	_current_hp = hp
	GlobalEventBus.update_hpbar.emit(_current_hp, hp)

func _process(_delta: float) -> void:
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()
	
	var camera = get_viewport().get_camera_2d()
	var mouse_direction : Vector2 = camera.get_global_mouse_position() - global_position
	sprite_2d.flip_h = mouse_direction.x > 0

func _physics_process(_d: float) -> void:	
	move_and_slide()

func update_animation(anim_name : String) -> void:
	animation_player.play(anim_name)

func take_damage(_hurt_box : HurtBox) -> void:
	_current_hp -= _hurt_box.damage
	GlobalEventBus.update_hpbar.emit(_current_hp, hp)
	if _current_hp <= 0:
		GlobalEventBus.player_died.emit()
