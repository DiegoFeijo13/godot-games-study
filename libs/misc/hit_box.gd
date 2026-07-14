class_name HitBox extends Area2D

signal damaged(hurt_box : HurtBox)

func take_damage(_h : HurtBox) -> void:	
	damaged.emit( _h)
