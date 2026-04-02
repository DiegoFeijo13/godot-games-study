class_name EnemyHpBar extends Node

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var enemy: Enemy = $".."

func _ready() -> void:
	enemy.update_hpbar.connect(_on_update)

func _on_update(current_value : float, max_value : float) -> void:
	if max_value <= 0:
		return
	
	var percent : float = (current_value / max_value) * 100
	progress_bar.value = percent
