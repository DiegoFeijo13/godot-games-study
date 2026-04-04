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
var _xp_mod : float = 0.0

var _bullet_speed_mod : float = 0.0

var direction : Vector2

func _ready() -> void:	
	state_machine.initialize(self)
	_current_hp = MAX_HP
	GlobalEventBus.player_loaded.emit(self)
	GlobalEventBus.update_hpbar.emit(_current_hp, MAX_HP)
	GlobalEventBus.modifiers_changed.connect(_on_modifiers_change)
	_send_update_status()

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
	_send_update_status()

func update_xp(delta : float) -> void:
	var xp_to_add := delta * (1.0 + _xp_mod)
	var levels_gained = int((_xp + xp_to_add) / _max_xp)
	_xp = int(xp_to_add) % int(_max_xp)
	if levels_gained > 0:
		_level += levels_gained
	GlobalEventBus.update_xpbar.emit(_xp, _max_xp)
	GlobalEventBus.level_up.emit(levels_gained, _level)
	_send_update_status()

func _on_modifiers_change(modifiers : ModifiersResponse) -> void:	
	# asserting new hp doesnt come empty
	if _max_hp_mod != modifiers.hp_add:
		var current_hp = _current_hp
		var new_hp = modifiers.hp_add - _max_hp_mod
		_max_hp_mod = int(modifiers.hp_add)
		_current_hp = clampi(current_hp + new_hp, _current_hp, get_max_hp())	
	_xp_mod = modifiers.xp_mod
	_speed_mod = modifiers.player_speed_mod
	_bullet_speed_mod = modifiers.bullet_speed_mod
	GlobalEventBus.update_xpbar.emit(_xp, _max_xp)
	GlobalEventBus.update_hpbar.emit(_current_hp, get_max_hp())
	_send_update_status()

func _send_update_status() -> void:
	var status_data = PlayerStatusData.new()
	status_data.current_hp = _current_hp
	status_data.max_hp = get_max_hp()
	status_data.bullet_speed_mod = _bullet_speed_mod
	status_data.current_xp = _xp
	status_data.xp_mod = _xp_mod
	status_data.next_level_xp = _max_xp
	GlobalEventBus.update_status_screen.emit(status_data)
	
