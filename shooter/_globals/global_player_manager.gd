extends Node

const INVENTORY_DATA : InventoryData = preload("uid://3adpuhlrdqrj")

var player : Player

# Modifiers
var hp_add : int = 0
var xp_mod : float = 0.0
var bullet_speed_mod : float = 0.0
var player_speed_mod : float = 0.0
var item_magnet_radius_mod : float = 0.0

func _ready() -> void:
	GlobalEventBus.player_loaded.connect(_on_player_loaded)
	GlobalEventBus.pickup_item.connect(_on_pick_up_item)
	GlobalEventBus.pickup_upgrade.connect(_on_pick_up_upgrade)

func _on_player_loaded(_player : Player) -> void:
	player = _player

func _on_pick_up_item(item_data : ItemData) -> void:
	if item_data.xp_amount > 0:
		player.update_xp(item_data.xp_amount)
	
	if item_data.heal_power > 0:
		player.update_hp(item_data.heal_power)

func _on_pick_up_upgrade(upgrade_data : UpgradeData) -> void:
	if INVENTORY_DATA.add_upgrade(upgrade_data):
		_recalculate_upgrades_modifiers()

func _recalculate_upgrades_modifiers() -> void:
	hp_add = 0
	xp_mod = 0.0
	bullet_speed_mod = 0.0
	player_speed_mod = 0.0
	item_magnet_radius_mod = 0.0
	
	for u in INVENTORY_DATA.upgrades:
		if u == null or u.quantity < 1:
			continue
		hp_add += u.upgrade_data.hp_add * u.quantity
		xp_mod += u.upgrade_data.xp_mod * u.quantity
		bullet_speed_mod += u.upgrade_data.bullet_speed_mod * u.quantity
		player_speed_mod += u.upgrade_data.player_speed_mod * u.quantity
		item_magnet_radius_mod += u.upgrade_data.item_magnet_radius_mod * u.quantity
	
	GlobalEventBus.modifiers_changed.emit()

func get_player_global_position() -> Vector2:
	if player:
		return player.global_position
	return Vector2.ZERO
