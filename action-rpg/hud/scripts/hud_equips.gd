class_name HudEquips extends Control

@onready var sword: TextureRect = $PanelContainer/GridContainer/Sword
@onready var shield: TextureRect = $PanelContainer/GridContainer/Shield
@onready var armor: TextureRect = $PanelContainer/GridContainer/Armor

func update_equips() -> void:
	if GlobalPlayerManager.inventory.sword_equip:
		sword.texture = GlobalPlayerManager.inventory.sword_equip.texture
	if GlobalPlayerManager.inventory.shield_equip:
		shield.texture = GlobalPlayerManager.inventory.shield_equip.texture
	if GlobalPlayerManager.inventory.armor_equip:
		armor.texture = GlobalPlayerManager.inventory.armor_equip.texture
