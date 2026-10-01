@tool
class_name NPC extends CharacterBody2D

@export var npc_resource : NPCResource : set = _set_npc_resource

@onready var sprite : Sprite2D = $Sprite2D

func _ready() -> void:
	setup_npc()
	if Engine.is_editor_hint():
		return

func setup_npc() -> void:
	if npc_resource:
		if sprite:
			sprite.texture = npc_resource.sprite

func _set_npc_resource( _npc : NPCResource) -> void:
	npc_resource = _npc
	setup_npc()

func toggle_highlight(value: bool) -> void:
	if sprite.material == null:
		return
	var center_distance_cap : int = 0
	if value:
		center_distance_cap = 1
	sprite.material.set("shader_parameter/center_distance_cap", center_distance_cap)

	
