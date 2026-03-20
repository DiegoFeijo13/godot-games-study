class_name Brick extends CharacterBody2D

signal brick_destroyed

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var brick_state_machine: BrickStateMachine = $BrickStateMachine
@onready var hit_box: BrickHitBox = $HitBox

@export_range(1, 6, 1) 
var hp : int = 1

var invunerable : bool = false
var score : int = (hp + ((hp-1) * 2)) * 10
var current_hp : int = 1
var colors = [
	Color("4248c8"),
	Color("48a048"),
	Color("a2a22a"),
	Color("b47a30"),
	Color("c66c3a"),
	Color("c84848")]

func _ready() -> void:
	brick_state_machine.initialize(self)
	current_hp = hp
	sprite_2d.self_modulate = colors[current_hp-1]
	hit_box.damaged.connect(take_damage)

func take_damage(_hurt_box : BallHurtBox) -> void:
	if invunerable == true:
		return
	current_hp -= _hurt_box.damage	
	if current_hp > 0:		
		sprite_2d.self_modulate = colors[current_hp-1]
	else:
		brick_destroyed.emit()
	
