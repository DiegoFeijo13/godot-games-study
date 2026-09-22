class_name PlayerManager extends Node

const PLAYER = preload("res://player/player.tscn")
var inventory : PlayerInventoryData = preload("res://player/inventory/player_inventory.tres")

var level_one_sword : EquipData = preload("uid://dscl3340w888d")
var level_one_armor : EquipData = preload("uid://jtyjbm3bxbig")
var boomerang : ToolData = preload("uid://c0jgk2ecd32m5")

var player : Player
var player_spawned : bool = false

func _ready() -> void:
	add_player_instance(Vector2.ZERO)
	inventory.equip_sword(level_one_sword) #TODO:temp for testing, remove it when menu GUI is done
	inventory.equip_armor(level_one_armor) #TODO:temp for testing, remove it when menu GUI is done
	inventory.add_tool(boomerang) #TODO:temp for testing, remove it when menu GUI is done
	
	GlobalEventBus.set_player_position.connect(_on_set_position)
	GlobalEventBus.set_player_parent.connect(_on_set_player_parent)
	GlobalEventBus.remove_player_parent.connect(_on_remove_player_parent)
	GlobalEventBus.player_spawn.connect(add_player_instance)
	GlobalEventBus.player_heal.connect(_on_player_heal)
	GlobalEventBus.player_take_damage.connect(_on_player_take_damage)
	GlobalEventBus.player_get_gold.connect(_on_player_get_gold)
	GlobalEventBus.player_lose_gold.connect(_on_player_lose_gold)
	GlobalEventBus.player_pickup_item.connect(_on_player_pickup_item)
	
	_heal_player(inventory.max_hp)
	_add_gold(-9999)

func add_player_instance(pos: Vector2) -> void:
	player = PLAYER.instantiate() as Player
	player.global_position = pos
	add_child(player)

func _heal_player(value : int) -> void:
	inventory.update_hp(value)
	GlobalEventBus.player_hp_updated.emit(inventory.current_hp, inventory.max_hp)

func _add_gold(value : int) -> void:
	inventory.update_gold(value)
	GlobalEventBus.player_gold_updated.emit(inventory.current_gold)

func _add_key(value : int) -> void:
	inventory.update_key(value)
	GlobalEventBus.player_key_count_updated.emit(inventory.current_key_count)

func _on_set_position(new_pos : Vector2) -> void:
	player.global_position = new_pos

func _on_set_player_parent(node : Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	node.add_child(player)

func _on_remove_player_parent(node : Node2D) -> void:	
	node.remove_child(player)

func _on_player_heal(value : int) -> void:
	_heal_player(value)

func _on_player_take_damage(value : int) -> void:
	_heal_player(-value)

func _on_player_get_gold(value : int) -> void:
	_add_gold(value)

func _on_player_lose_gold(value : int) -> void:
	_add_gold(-value)

func _on_player_pickup_item(drop : ItemDropData) -> void:
	if drop.heal_power > 0:
		_heal_player(drop.heal_power)
		return
	
	if drop.gold_amount > 0:
		_add_gold(drop.gold_amount)
		return
	
	if drop.key_amount > 0:
		_add_key(drop.key_amount)
		return
