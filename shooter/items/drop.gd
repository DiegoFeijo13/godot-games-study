@tool
class_name Drop extends CharacterBody2D

@export var item_data : ItemData : set = _set_item_data

@onready var area_2d: Area2D = $Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	_update_texture()
	if Engine.is_editor_hint():
		return
	area_2d.body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	velocity -= velocity * delta * 4

func _on_body_entered(b : Node2D) -> void:
	if b is Player and item_data:
		GlobalEventBus.pickup_item.emit(item_data)
		_item_picked_up()
		pass

func _update_texture() -> void:
	if item_data and sprite_2d:
		sprite_2d.texture = item_data.texture
		sprite_2d.modulate = item_data.texture_modulate
		sprite_2d.scale.x = item_data.texture_scale
		sprite_2d.scale.y = item_data.texture_scale

func _set_item_data( value : ItemData ) -> void:
	item_data = value
	_update_texture()	

func _item_picked_up() -> void:
	area_2d.body_entered.disconnect(_on_body_entered)
	visible = false
	queue_free()
	
