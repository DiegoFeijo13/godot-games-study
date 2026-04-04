class_name PlayerStatusScreen extends Control

@onready var hp_data: Label = $GridContainer/HpData
@onready var xp_data: Label = $GridContainer/XpData
@onready var xp_mod_data: Label = $GridContainer/XpModData
@onready var player_speed_data: Label = $GridContainer/PlayerSpeedData
@onready var bullet_speed_data: Label = $GridContainer/BulletSpeedData



func _ready() -> void:
	GlobalEventBus.update_status_screen.connect(_on_update)

func _on_update(data : PlayerStatusData) -> void:	
	hp_data.text = str(data.current_hp) + "/" + str(data.max_hp)
	xp_data.text = str(data.current_xp) + "/" + str(data.next_level_xp)
	xp_mod_data.text = "% " + str(data.xp_mod * 100)
	player_speed_data.text = "% " + str(data.speed * 100)
	bullet_speed_data.text = "% " + str(data.bullet_speed_mod * 100)
