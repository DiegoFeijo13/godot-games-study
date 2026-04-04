class_name UpgradeChoicesUI extends Control

const EPIC_BUTTON_THEME = preload("uid://dpldtktruigws")
const RARE_BUTTON_THEME = preload("uid://coodd8i7d7ph5")
const UNCOMMON_BUTTON_THEME = preload("uid://cter0lvn1og0x")
const MAIN_THEME = preload("uid://dn741ckakw5rx")

var btn_1_upgrade_data : UpgradeData
var btn_2_upgrade_data : UpgradeData
var btn_3_upgrade_data : UpgradeData

@onready var upgrade_1: Button = $"Upgrade 1"
@onready var upgrade_2: Button = $"Upgrade 2"
@onready var upgrade_3: Button = $"Upgrade 3"

@onready var title_label: Label = $TitleLabel

func update_buttons(choices : Array[UpgradeData]) -> void:
	if choices == null or choices.size() == 0:
		return
	var player_level = GlobalPlayerManager.get_player_current_level()
	
	title_label.text = title_label.text.replace("%s", str(player_level))
	
	upgrade_1.text = choices[0].description
	_update_button_theme(upgrade_1, choices[0].rarity)
	btn_1_upgrade_data = choices[0]
	upgrade_1.button_up.connect(_on_upgrade1_up)
	upgrade_2.text = choices[1].description
	_update_button_theme(upgrade_2, choices[1].rarity)
	btn_2_upgrade_data = choices[1]
	upgrade_2.button_up.connect(_on_upgrade2_up)
	
	upgrade_3.text = choices[2].description
	_update_button_theme(upgrade_3, choices[2].rarity)
	btn_3_upgrade_data = choices[2]
	upgrade_3.button_up.connect(_on_upgrade3_up)

func _update_button_theme(b : Button, rarity : UpgradeData.UpgradeRarity) -> void:
	match rarity:
		UpgradeData.UpgradeRarity.epic:
			b.theme = EPIC_BUTTON_THEME
		UpgradeData.UpgradeRarity.rare:
			b.theme = RARE_BUTTON_THEME
		UpgradeData.UpgradeRarity.uncommon:
			b.theme = UNCOMMON_BUTTON_THEME
		_:
			b.theme = MAIN_THEME

func _on_upgrade1_up() -> void:
	GlobalEventBus.ui_chose_upgrade.emit(btn_1_upgrade_data)
	_disconnect_buttons()

func _on_upgrade2_up() -> void:
	GlobalEventBus.ui_chose_upgrade.emit(btn_2_upgrade_data)
	_disconnect_buttons()

func _on_upgrade3_up() -> void:
	GlobalEventBus.ui_chose_upgrade.emit(btn_3_upgrade_data)
	_disconnect_buttons()

func _disconnect_buttons() -> void:
	upgrade_1.button_up.disconnect(_on_upgrade1_up)
	upgrade_2.button_up.disconnect(_on_upgrade2_up)
	upgrade_3.button_up.disconnect(_on_upgrade3_up)
