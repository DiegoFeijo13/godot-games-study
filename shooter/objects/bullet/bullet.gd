class_name Bullet extends CharacterBody2D

const LIFETIME : float = 0.8

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hurt_box: HurtBox = $HurtBox

var speed : float = 700.0
var damage : int = 1

var direction : Vector2
var _current_lifetime : float

func _ready() -> void:
	animation_player.play("moving")
	_current_lifetime = LIFETIME
	hurt_box.damage = damage
	hurt_box.did_damage.connect(_on_damage_done)

func _process(_d: float) -> void:
	_current_lifetime -= _d
	if _current_lifetime <= 0:
		queue_free()

func _physics_process(_d: float) -> void:
	velocity = direction * speed
	
	if move_and_slide():
		queue_free()

func _on_damage_done() -> void:
	set_physics_process(false)
	queue_free()
