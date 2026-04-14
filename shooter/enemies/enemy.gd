class_name Enemy extends CharacterBody2D

signal enemy_damaged(h : HurtBox)
signal enemy_destroyed(h : HurtBox)
signal update_hpbar(current_value : float, max_value : float)

@export var speed : float = 150.0
@export var hp : int = 3

@onready var state_machine: EnemyStateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

var current_hp : int
var invulnerable: bool = false
var current_speed : float
var direction : Vector2

func _ready() -> void:
	state_machine.initialize(self)
	current_hp = hp
	current_speed = speed
	update_hpbar.emit(current_hp, hp)
	pass
	
func _physics_process(_d: float) -> void:	
	move_and_slide()

func set_direction(new_direction : Vector2) -> bool:
	direction = new_direction
	if direction == Vector2.ZERO:
		return false
	
	sprite_2d.flip_h = direction.x < 0
		
	velocity = direction * current_speed
	return true

func set_speed(s : float) -> void:
	current_speed = s

func reset_speed() -> void:
	current_speed = speed

func play_animation(anim_name : String) -> void:
	animation_player.play(anim_name)

func take_damage(_h : HurtBox) -> void:
	if invulnerable:
		return
	
	current_hp -= _h.damage
	update_hpbar.emit(current_hp, hp)
	if current_hp > 0:
		enemy_damaged.emit(_h)
	else:
		enemy_destroyed.emit(_h)
