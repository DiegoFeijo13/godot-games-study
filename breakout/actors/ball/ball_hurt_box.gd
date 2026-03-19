class_name BallHurtBox extends Area2D

signal did_damage

@export var damage : int = 1

func _ready() -> void:
	area_entered.connect(on_area_entered)

func on_area_entered(a : Area2D) -> void:	
	if a is BrickHitBox:
		did_damage.emit()
		a.take_damage(self)
