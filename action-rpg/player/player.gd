class_name Player extends CharacterBody2D

const SPEED : float = 100.0
const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var hit_box: HitBox = $HitBox

var direction : Vector2
var cardinal_direction : Vector2
var invulnerable : bool = false

func _ready() -> void:
	state_machine.initialize(self)
	hit_box.damaged.connect(_on_take_damage)

func _process(_delta: float) -> void:
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()		

func _physics_process(_d: float) -> void:	
	move_and_slide()

func set_direction() -> bool:
	if direction == Vector2.ZERO:
		return false
	
	# bias the direction by the cardinal_direction to hold onto the first pressed key
	var direction_id : int = int( round( (direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size() ) )	
	var new_dir = DIR_4[ direction_id ]		
	
	if new_dir == cardinal_direction:
		return false
		
	cardinal_direction = new_dir	
	sprite_2d.scale.x = -1 if cardinal_direction == Vector2.RIGHT else 1
	return true

func update_animation(anim_name : String) -> void:
	animation_player.play(anim_name + "/" + anim_direction())
	pass

func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	if cardinal_direction == Vector2.UP:
		return "up"
	return "side"
	
func get_speed() -> float:
	return SPEED

func _on_take_damage(hurt_box : HurtBox) -> void:
	GlobalEventBus.player_take_damage.emit(hurt_box.damage)

func set_invulnerable(value : bool) -> void:
	invulnerable = value
	hit_box.monitoring = !value
