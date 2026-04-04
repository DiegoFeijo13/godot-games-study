class_name GameOverUI extends Control

@onready var restart_button: Button = $RestartButton

func _ready() -> void:
	restart_button.button_up.connect(_on_restart_button_button_up)

func _on_restart_button_button_up() -> void:
	GlobalEventBus.restart.emit()
