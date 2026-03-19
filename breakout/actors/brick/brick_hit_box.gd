class_name BrickHitBox extends Area2D

signal damaged(hurt_box : BallHurtBox)

func take_damage(hurt_box : BallHurtBox) -> void:
	damaged.emit(hurt_box)
