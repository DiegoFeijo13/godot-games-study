class_name PlayerManager extends Node

const PLAYER = preload("res://player/player.tscn")

var player : Player
var player_spawned : bool = false

func _ready() -> void:
	add_player_instance(Vector2.ZERO)
	GlobalEventBus.set_player_position.connect(_on_set_position)
	GlobalEventBus.set_player_parent.connect(_on_set_player_parent)
	GlobalEventBus.remove_player_parent.connect(_on_remove_player_parent)
	GlobalEventBus.player_spawn.connect(add_player_instance)

func add_player_instance(pos: Vector2) -> void:
	player = PLAYER.instantiate() as Player
	player.global_position = pos
	print(pos)
	add_child(player)

func _on_set_position(new_pos : Vector2) -> void:
	player.global_position = new_pos

func _on_set_player_parent(node : Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	node.add_child(player)

func _on_remove_player_parent(node : Node2D) -> void:	
	node.remove_child(player)
