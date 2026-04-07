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
	fire_rate,
	player_speed,
	item_magnet,
	bullet_damage
}

@export_category("Attributes")
@export var description : String = ""
@export var rarity : UpgradeRarity
@export var category : UpgradeCategory

@export_category("Modifiers")
@export var hp_add : int = 0
@export var xp_mod : float = 0.0
@export var fire_rate_mod : float = 0.0
@export var player_speed_mod : float = 0.0
@export var item_magnet_radius_mod : float = 0.0
@export var damage_mod : float = 0.0
