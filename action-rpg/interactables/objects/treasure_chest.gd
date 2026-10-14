@tool
class_name TreasureChest extends Node2D

@export var item_data : ItemDropData : set = _set_item_data
@export var equip_data : EquipData : set = _set_equip_data
@export var quantity : int = 1 : set = _set_quantity

@onready var sprite: Sprite2D = $Sprite2D
@onready var item_sprite: Sprite2D = $ItemSprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var interact_area: Area2D = $Area2D

var is_open : bool = false

func _ready() -> void:
	_update_texture()
	
	if Engine.is_editor_hint():
		return
		
	interact_area.area_entered.connect( _on_area_enter )	
	interact_area.area_exited.connect( _on_area_exit )	
	pass
	
func _set_item_data( value : ItemDropData ) -> void:
	item_data = value
	_update_texture()
	pass

func _set_equip_data( value : EquipData ) -> void:
	equip_data = value
	_update_texture()
	pass

func _set_quantity( value : int ) -> void:
	quantity = value
	pass

func _on_area_enter( _a : Area2D ) -> void:
	toggle_highlight(true)
	GlobalEventBus.player_interact_pressed.connect(_on_player_interact)
	pass
	
func _on_area_exit( _a : Area2D ) -> void:
	toggle_highlight(false)
	GlobalEventBus.player_interact_pressed.disconnect(_on_player_interact)
	pass	
	
func _on_player_interact() -> void:
	if is_open:
		return
	is_open = true
	
	animation_player.play("open_chest")
	if item_data and quantity > 0:
		GlobalEventBus.player_pickup_item.emit(item_data)
	elif equip_data:
		GlobalEventBus.player_get_equip.emit(equip_data)
	else:
		printerr("No items in chest")
		push_error("No items in chest. Chest name: ", name)
	pass
		

func _update_texture() -> void:
	if item_sprite == null:
		return
	if item_data:
		item_sprite.texture = item_data.texture
	elif equip_data:
		item_sprite.texture = equip_data.texture

func toggle_highlight(value: bool) -> void:
	if sprite.material == null:
		return
	var center_distance_cap : int = 0
	if value:
		center_distance_cap = 1
	sprite.material.set("shader_parameter/center_distance_cap", center_distance_cap)
