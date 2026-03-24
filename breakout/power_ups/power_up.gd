class_name PowerUp extends CharacterBody2D

enum Power_Type {
	OneUp,
	ExtraBall,	
	Slow
}

const FALL_SPEED : float = 300.0

@export var type : Power_Type

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D

var color = [
	Color("00ae00"),
	Color("d200d2"),
	Color("e08f00")
]

func _ready() -> void:
	sprite_2d.self_modulate = color[type]
	area_2d.area_entered.connect(_on_area_entered)

func _physics_process(_delta: float) -> void:
	position.y += FALL_SPEED * _delta

func _on_area_entered(_a : Area2D) -> void:
	if _a is Floor:		
		GlobalEventBus.power_up_despawn.emit()
		queue_free()
	
	if _a is PaddleArea:		
		GlobalEventBus.got_power_up.emit(self)
		queue_free()
