class_name HurtBox extends Area2D

signal did_damage

@export var damage : int = 1

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(a : Area2D) -> void:
	if a is HitBox:
		did_damage.emit()
		a.take_damage(self)
