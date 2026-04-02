class_name EventBus extends Node

# Player events
@warning_ignore("unused_signal") signal player_loaded(player : Player)
@warning_ignore("unused_signal") signal pickup_item(item_data : ItemData)
@warning_ignore("unused_signal") signal pickup_upgrade(upgrade_data : UpgradeData)
@warning_ignore("unused_signal") signal player_died
@warning_ignore("unused_signal") signal level_up(current_level : int)
@warning_ignore("unused_signal") signal modifiers_changed

# Enemy events
@warning_ignore("unused_signal") signal enemy_spawned
@warning_ignore("unused_signal") signal enemy_died(e : Enemy)

# Game events
@warning_ignore("unused_signal") signal game_paused(p : bool)
@warning_ignore("unused_signal") signal restart

# GUI events
@warning_ignore("unused_signal") signal update_hpbar(current_value : float, max_value : float)
@warning_ignore("unused_signal") signal update_xpbar(current_value : float, max_value : float)
