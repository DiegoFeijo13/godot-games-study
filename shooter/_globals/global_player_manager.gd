extends Node

const INVENTORY_DATA : InventoryData = preload("uid://3adpuhlrdqrj")

var player : Player

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
	INVENTORY_DATA.add_upgrade(upgrade_data)
	_recalculate_upgrades_modifiers()
	GlobalEventBus.pickup_upgrade_done.emit()

func _recalculate_upgrades_modifiers() -> void:
	var modifiers = ModifiersResponse.new()	
	
	for u in INVENTORY_DATA.upgrades:
		if u == null or u.quantity < 1:
			continue
		modifiers.hp_add += u.upgrade_data.hp_add * u.quantity
		modifiers.xp_mod += u.upgrade_data.xp_mod * u.quantity
		modifiers.bullet_speed_mod += u.upgrade_data.bullet_speed_mod * u.quantity
		modifiers.player_speed_mod += u.upgrade_data.player_speed_mod * u.quantity
		modifiers.item_magnet_radius_mod += u.upgrade_data.item_magnet_radius_mod * u.quantity
	
	GlobalEventBus.modifiers_changed.emit(modifiers)

func get_player_global_position() -> Vector2:
	if player:
		return player.global_position
	return Vector2.ZERO

func get_player_current_level() -> int:
	if player:
		return player._level
	return 0
