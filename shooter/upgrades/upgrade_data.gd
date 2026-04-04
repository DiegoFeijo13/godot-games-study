class_name UpgradeData extends Resource

enum UpgradeRarity {
	common,
	uncommon,
	rare,
	epic
}

enum UpgradeCategory {
	hp_max,
	xp_max,
	bullet_speed,
	player_speed,
	item_magnet
}

@export_category("Attributes")
@export var description : String = ""
@export var rarity : UpgradeRarity
@export var category : UpgradeCategory

@export_category("Modifiers")
@export var hp_add : int = 0
@export var xp_mod : float = 0.0
@export var bullet_speed_mod : float = 0.0
@export var player_speed_mod : float = 0.0
@export var item_magnet_radius_mod : float = 0.0
