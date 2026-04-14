class_name EnemySpawner extends Node2D

@export var easy_enemies_scenes : Array[PackedScene]
@export var hard_enemies_scenes : Array[PackedScene]

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(_spawn)

func _spawn() -> void:
	if GlobalGameState.can_spawn_enemy() == false:
		return
	
	var e : int = 0
	var enemy : Enemy = null
	if GlobalPlayerManager.get_player_current_level() > 5 and randf() > 0.5:
		e = randi_range(0, hard_enemies_scenes.size() -1)	
		enemy = hard_enemies_scenes[e].instantiate() as Enemy		
	else:
		e = randi_range(0, easy_enemies_scenes.size() -1)	 
		enemy = easy_enemies_scenes[e].instantiate() as Enemy
	
	add_child(enemy)
	GlobalEventBus.enemy_spawned.emit()	
	pass
