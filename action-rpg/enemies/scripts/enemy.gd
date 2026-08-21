class_name Enemy extends CharacterBody2D

signal enemy_damaged (hurt_box : HurtBox)
signal enemy_destroyed (hurt_box : HurtBox)

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@export var hp : int = 3

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.DOWN
var invulnerable : bool = false

@onready var state_machine: EnemyStateMachine = $EnemyStateMachine
@onready var hit_box: HitBox = $HitBox
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	state_machine.initialize(self)
	hit_box.damaged.connect(_on_damaged)

func _physics_process(_delta: float) -> void:
	move_and_slide()

func set_direction(new_direction : Vector2) -> bool:
	direction = new_direction
	if direction == Vector2.ZERO:
		return false
	
	# bias the direction by the cardinal_direction
	var direction_id : int = int( round( 
			(direction + cardinal_direction * 0.1).angle() 
			/ TAU * DIR_4.size() 
	) )	
	
	var new_dir = DIR_4[ direction_id ]
	
	if new_dir == cardinal_direction:
		return false
		
	cardinal_direction = new_dir	
	sprite_2d.scale.x = -1 if cardinal_direction == Vector2.RIGHT else 1
	return true	

func update_animation(state : String) -> void:
	animation_player.play(state + "/" + anim_direction())
	pass
	
	
func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else :
		return "side"

func _on_damaged(_h : HurtBox) -> void:
	if invulnerable == true:
		return
	hp -= _h.damage
	
	if hp > 0:
		enemy_damaged.emit(_h)
	else:
		enemy_destroyed.emit(_h)
