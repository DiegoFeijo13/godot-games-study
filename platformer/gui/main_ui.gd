class_name MainUI extends CanvasLayer

@onready var gui: Control = $GUI
@onready var coins_label: Label = $GUI/CoinsLabel
@onready var deaths_label: Label = $GUI/DeathsLabel

@onready var finish_dialog: Control = $FinishDialog
@onready var status: Label = $FinishDialog/Status


func _ready() -> void:
	finish_dialog.visible = false
	GlobalEventBus.update_ui.connect(_on_update_ui)
	GlobalEventBus.not_enough_coins.connect(_on_not_enough_coins)
	GlobalEventBus.show_finish_dialog.connect(_on_show_finish_dialog)

func _on_update_ui(coins: int, deaths : int) -> void:
	coins_label.label_settings.font_color = Color.WHITE
	coins_label.text = "Coins: " + str(coins) + " / 100"
	deaths_label.text = "Deaths: " + str(deaths)
	pass

func _on_not_enough_coins() -> void:
	coins_label.label_settings.font_color = Color.RED

func _on_show_finish_dialog(coins: int, deaths: int) -> void:
	get_tree().paused = true
	gui.visible = false
	finish_dialog.visible = true
	status.text = "Coins: " + str(coins) + "\nDeaths: " + str(deaths)

func _on_restart_button_up() -> void:
	GlobalEventBus.restart.emit()
