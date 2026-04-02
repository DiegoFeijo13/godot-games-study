class_name GameState extends Node

var enemies_on_screen : int
var max_enemies_on_screen : int = 8
var is_game_over : bool

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

func _on_player_died() -> void:
	get_tree().paused = true
	is_game_over = true

func _on_restart() -> void:
	get_tree().create_timer(0.5).timeout.connect(_restart)

func _restart() -> void:
	get_tree().reload_current_scene()
	get_tree().paused = false
	enemies_on_screen = 0
	is_game_over = false
