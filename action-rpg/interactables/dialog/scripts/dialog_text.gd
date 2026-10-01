@tool
class_name DialogText extends Node

@export var npc_info: NPCResource
@export_multiline var text : String = "Placeholder text" : set = _set_text
var example_dialog : DialogHUD

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	check_npc_data()
	
func check_npc_data() -> void:
	if npc_info != null:
		return

	var p : Node = self
	var _checking: bool = true
	while _checking:
		p = p.get_parent()
		if p:
			if p is NPC and p.npc_resource:
				npc_info = p.npc_resource
				_checking = false
		else:
			_checking = false

func _set_text(value:String) -> void:
	text = value
	if Engine.is_editor_hint():
		if example_dialog != null:
			_set_editor_display()
	
func _set_editor_display() -> void:
	example_dialog.set_dialog_text(self)
	example_dialog.content.visible_characters = -1
