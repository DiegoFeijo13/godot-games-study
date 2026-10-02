@tool
class_name DialogInteraction extends Area2D

signal player_interacted
signal finished

@export var enabled: bool = true

var dialog_items: Array[DialogItem]
var parent_npc : NPC


func _ready() -> void:
	if Engine.is_editor_hint():
		return

	area_entered.connect(_on_area_enter)
	area_exited.connect(_on_area_exit)
	
	if get_parent() is NPC:
		parent_npc = get_parent() as NPC
	
	for c in get_children():
		if c is DialogItem:
			dialog_items.append(c)

func _get_configuration_warnings() -> PackedStringArray:
	if _check_for_dialog_items() == false:
		return ["Requires at least one DialogItem node"]
	else:
		return []

func _check_for_dialog_items() -> bool:
	for c in get_children():
		if c is DialogItem:
			return true
	return false

func _on_player_interact() -> void:
	player_interacted.emit()
	await get_tree().process_frame
	await get_tree().process_frame
	DialogSystem.show_dialog(dialog_items)
	DialogSystem.finished.connect(_on_dialog_finish)
	pass
	
func _on_area_enter(_a:Area2D) -> void:
	if enabled == false || dialog_items.size() == 0:
		return
	if parent_npc:
		parent_npc.toggle_highlight(true)
	GlobalEventBus.player_interact_pressed.connect(_on_player_interact)

func _on_area_exit(_a:Area2D) -> void:
	if parent_npc:
		parent_npc.toggle_highlight(false)
	GlobalEventBus.player_interact_pressed.disconnect(_on_player_interact)	

func _on_dialog_finish() -> void:
	DialogSystem.finished.disconnect(_on_dialog_finish)
	finished.emit()
