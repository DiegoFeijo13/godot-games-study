class_name EnemySpawner extends Node2D

@export var enemy_scene : PackedScene

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(_spawn)

func _spawn() -> void:
	if GlobalGameState.can_spawn_enemy() == false:
		return
	
	var enemy = enemy_scene.instantiate() as Enemy
	add_child(enemy)
	GlobalEventBus.enemy_spawned.emit()	
	pass
