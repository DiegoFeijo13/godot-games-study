class_name Player extends CharacterBody2D

const SPEED : float = 300.0
const MAX_HP : int = 3

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: PlayerStateMachine = $StateMachine

var _current_hp : int
var _max_hp_mod : int

var _speed_mod : float

var _level : int = 1
var _xp : float = 0
var _max_xp : float = 100.0
var _xp_mod : float = 1.0

var direction : Vector2

func _ready() -> void:	
	state_machine.initialize(self)
	_current_hp = MAX_HP
	GlobalEventBus.player_loaded.emit(self)
	GlobalEventBus.update_hpbar.emit(_current_hp, MAX_HP)
	GlobalEventBus.modifiers_changed.connect(_on_modifiers_change)

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

func get_max_hp() -> int:
	return MAX_HP + _max_hp_mod

func get_speed() -> float:
	return SPEED #* _speed_mod

func update_animation(anim_name : String) -> void:
	animation_player.play(anim_name)

func update_hp(delta : int) -> void:
	_current_hp = clampi(_current_hp + delta, 0, get_max_hp())
	GlobalEventBus.update_hpbar.emit(_current_hp, get_max_hp())
	if _current_hp <= 0:
		GlobalEventBus.player_died.emit()

func update_xp(delta : float) -> void:
	var xp_to_add := delta * _xp_mod
	_xp += xp_to_add
	if _xp >= _max_xp:
		_level_up()
	GlobalEventBus.update_xpbar.emit(_xp, _max_xp)

func _level_up() -> void:
	_xp = maxf(_xp - _max_xp, 0.0)
	_level += 1
	GlobalEventBus.level_up.emit(_level)
	GlobalEventBus.update_xpbar.emit(_xp, _max_xp)
	if _xp >= _max_xp:
		_level_up()

func _on_modifiers_change() -> void:
	_max_hp_mod = GlobalPlayerManager.hp_add
	_xp_mod = GlobalPlayerManager.xp_mod
	#_speed_mod = GlobalPlayerManager.
