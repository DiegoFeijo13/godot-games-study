class_name EnemyHitBox extends Area2D

@onready var enemy: Enemy = $".."

func take_damage(_h : HurtBox) -> void:	
	enemy.take_damage(_h)
