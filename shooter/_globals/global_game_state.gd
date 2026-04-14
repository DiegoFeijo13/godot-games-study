class_name GameState extends Node

const MAX_ENEMIES_ON_START : int = 4

var enemies_on_screen : int
var max_enemies_on_screen : int
var can_player_control : bool = true

func _ready() -> void:
	max_enemies_on_screen = MAX_ENEMIES_ON_START
	
	GlobalEventBus.enemy_spawned.connect(_on_enemy_spawned)
	GlobalEventBus.enemy_died.connect(_on_enemy_died)
	GlobalEventBus.player_died.connect(_on_player_died)
	GlobalEventBus.restart.connect(_on_restart)	
	GlobalEventBus.level_up.connect(_on_level_up)
	GlobalEventBus.pickup_upgrade_done.connect(_on_pickup_upgrade_done)

func can_spawn_enemy() -> bool:
	return enemies_on_screen < max_enemies_on_screen

func _on_enemy_spawned() -> void:
	enemies_on_screen += 1

func _on_enemy_died(_e : Enemy) -> void:
	enemies_on_screen -= 1

func _on_player_died() -> void:
	get_tree().paused = true
	can_player_control = false

func _on_restart() -> void:
	get_tree().create_timer(0.5).timeout.connect(_restart)

func _restart() -> void:
	get_tree().reload_current_scene()
	get_tree().paused = false
	enemies_on_screen = 0
	can_player_control = true
	max_enemies_on_screen = MAX_ENEMIES_ON_START

func _on_level_up(_levels_gained : int, _current_level : int) -> void:
	get_tree().paused = true
	can_player_control = false
	max_enemies_on_screen += _levels_gained

func _on_pickup_upgrade_done() -> void:
	can_player_control = true
	get_tree().paused = false
	
