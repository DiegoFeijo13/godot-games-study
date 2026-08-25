class_name Bullet extends CharacterBody2D

@onready var hurtbox: HurtBox = $Hurtbox

var lifetime : float = 0.8
var speed : float = 700.0
var damage : int = 1
var direction : Vector2

func _ready() -> void:	
	hurtbox.did_damage.connect(_on_damage_done)
	hurtbox.damage = damage

func _process(_d: float) -> void:
	lifetime -= _d
	if lifetime <= 0:
		queue_free()

func _physics_process(_d: float) -> void:
	velocity = direction * speed
	
	if move_and_slide():
		queue_free()

func _on_damage_done() -> void:
	set_physics_process(false)
	queue_free()
