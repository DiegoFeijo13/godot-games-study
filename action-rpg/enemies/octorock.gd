extends CharacterBody2D

@onready var hit_box: HitBox = $HitBox

func _ready() -> void:
	hit_box.damaged.connect(_on_damaged)

func _on_damaged(_h : HurtBox) -> void:
	print(_h)
	print("Enemy took: ", _h.damage, " points of damage")
	
