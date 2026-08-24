class_name EnemyData extends Resource

@export var name : String = ""
@export var hp : int = 3

@export_category("Art")
@export var sprite : Texture2D

@export_category("AI")
@export var idle_state_duration_min : float = 0.5
@export var idle_state_duration_max : float = 1.5
@export var wander_speed : float = 20.0
@export var wander_state_animation_duration : float = 0.5
@export var wander_state_cycles_min : int = 1
@export var wander_state_cycles_max : int = 3
@export var stun_knockback_speed : float = 200.0
@export var stun_decelerate_speed : float = 10.0
