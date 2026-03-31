class_name GameState extends Node

const MAX_XP : float = 100.0

var player : Player
var level : int
var enemies_on_screen : int
var max_enemies_on_screen : int = 8

var current_xp : float
var current_player_level : int = 1

var player_can_control : bool = true

func _ready() -> void:
	GlobalEventBus.enemy_spawned.connect(_on_enemy_spawned)
	GlobalEventBus.enemy_died.connect(_on_enemy_died)
	GlobalEventBus.player_died.connect(_on_player_died)
	GlobalEventBus.restart.connect(_on_restart)

func can_spawn_enemy() -> bool:
	return enemies_on_screen < max_enemies_on_screen

func _on_enemy_spawned() -> void:
	enemies_on_screen += 1

func _on_enemy_died(_e : Enemy) -> void:
	enemies_on_screen -= 1
	current_xp += _e.xp_grant
	_check_lvl_up()
	GlobalEventBus.update_xpbar.emit(current_xp, MAX_XP)

func _check_lvl_up() -> void:
	if current_xp >= MAX_XP:
		current_player_level += 1
		current_xp = 0
		GlobalEventBus.level_up.emit(current_player_level)

func _on_player_died() -> void:
	player_can_control = false
	get_tree().paused = true

func _on_restart() -> void:
	get_tree().create_timer(0.5).timeout.connect(_restart)

func _restart() -> void:
	get_tree().reload_current_scene()
	get_tree().paused = false
	player_can_control = true
	current_player_level = 1
	current_xp = 0
	enemies_on_screen = 0
