class_name PlayerManager extends Node

const PLAYER = preload("res://player/player.tscn")
var inventory : PlayerInventoryData = preload("res://player/inventory/player_inventory.tres")

var player : Player
var player_spawned : bool = false

func _ready() -> void:
	add_player_instance(Vector2.ZERO)
	inventory.equip_action_one(0) #TODO:temp for testing, remove it when menu GUI is done
	GlobalEventBus.set_player_position.connect(_on_set_position)
	GlobalEventBus.set_player_parent.connect(_on_set_player_parent)
	GlobalEventBus.remove_player_parent.connect(_on_remove_player_parent)
	GlobalEventBus.player_spawn.connect(add_player_instance)
	GlobalEventBus.player_heal.connect(_on_player_heal)
	GlobalEventBus.player_take_damage.connect(_on_player_take_damage)
	
	_on_player_heal(inventory.max_hp)

func add_player_instance(pos: Vector2) -> void:
	player = PLAYER.instantiate() as Player
	player.global_position = pos
	add_child(player)

func _on_set_position(new_pos : Vector2) -> void:
	player.global_position = new_pos

func _on_set_player_parent(node : Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	node.add_child(player)

func _on_remove_player_parent(node : Node2D) -> void:	
	node.remove_child(player)

func _on_player_heal(value : int) -> void:
	inventory.update_hp(value)
	GlobalEventBus.player_hp_updated.emit(inventory.current_hp, inventory.max_hp)

func _on_player_take_damage(value : int) -> void:
	inventory.update_hp(-value)
	GlobalEventBus.player_hp_updated.emit(inventory.current_hp, inventory.max_hp)
