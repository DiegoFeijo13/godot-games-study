class_name HurtBox extends Area2D

signal did_damage

@export var damage : int = 1

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(_a : Area2D) -> void:	
	if _a is HitBox or _a is EnemyHitBox:
		did_damage.emit()
		_a.take_damage(self)
