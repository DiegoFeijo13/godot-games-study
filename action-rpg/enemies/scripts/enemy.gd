class_name Enemy extends CharacterBody2D

signal enemy_damaged (hurt_box : HurtBox)
signal enemy_destroyed (hurt_box : HurtBox)
signal direction_changed (new_direction : Vector2)

@export var enemy_data : EnemyData
@export var drop_table : DropTableData

var hp : int
var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.DOWN
var invulnerable : bool = false
var attack_cooldown : float

@onready var state_machine: EnemyStateMachine = $EnemyStateMachine
@onready var hit_box: HitBox = $HitBox
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

var _current_attack_cooldown : float = 0

func _ready() -> void:
	state_machine.initialize(self)
	hit_box.damaged.connect(_on_damaged)
	hp = enemy_data.hp
	attack_cooldown = enemy_data.attack_cooldown

func _process(delta: float) -> void:
	_calculate_attack_cooldown(delta)

func _physics_process(_delta: float) -> void:
	move_and_slide()

func set_direction(new_direction : Vector2) -> bool:
	direction = new_direction
	if direction == Vector2.ZERO:
		return false
	
	var new_dir : Vector2 = GlobalContants.translate_to_dir4(direction, cardinal_direction)
	
	if new_dir == cardinal_direction:
		return false
		
	cardinal_direction = new_dir	
	direction_changed.emit(new_dir)
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

func _calculate_attack_cooldown(delta : float) -> void:
	if _current_attack_cooldown == 0:
		return
	_current_attack_cooldown = clampf(_current_attack_cooldown - delta, 0, attack_cooldown)

func start_cooldown() -> void:
	_current_attack_cooldown = attack_cooldown

func _on_damaged(_h : HurtBox) -> void:
	if invulnerable == true:
		return
	hp -= _h.damage
	
	if hp > 0:
		enemy_damaged.emit(_h)
	else:
		enemy_destroyed.emit(_h)
