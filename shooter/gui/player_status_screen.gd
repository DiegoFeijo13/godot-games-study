class_name PlayerStatusScreen extends Control

@onready var hp_data: Label = $GridContainer/HpData
@onready var xp_data: Label = $GridContainer/XpData
@onready var xp_mod_data: Label = $GridContainer/XpModData
@onready var player_speed_data: Label = $GridContainer/PlayerSpeedData
@onready var fire_rate_data: Label = $GridContainer/FireRateData
@onready var bullet_damage_data: Label = $GridContainer/BulletDamageData

func _ready() -> void:
	GlobalEventBus.update_status_screen.connect(_on_update)

func _on_update(data : PlayerStatusData) -> void:	
	hp_data.text = str(data.current_hp) + "/" + str(data.max_hp)
	xp_data.text = str(data.current_xp) + "/" + str(data.next_level_xp)
	xp_mod_data.text = "% " + str(data.xp_mod * 100)
	player_speed_data.text = "% " + str(data.speed * 100)
	fire_rate_data.text = "% " + str(data.fire_rate_mod * 100)
	bullet_damage_data.text = "% " + str(data.bullet_dmg_mod * 100)
