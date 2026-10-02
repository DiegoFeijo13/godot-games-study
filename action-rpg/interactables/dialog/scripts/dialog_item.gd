@tool
class_name DialogItem extends Node

@export var npc_info: NPCResource

@warning_ignore("untyped_declaration")
var editor_selection
var example_dialog : DialogSystemNode

func _ready() -> void:
	if Engine.is_editor_hint():
		editor_selection = Engine.get_singleton("EditorInterface").get_selection()
		editor_selection.selection_changed.connect(_on_selection_changed)
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

func _on_selection_changed() -> void:
	if editor_selection == null:
		return
	@warning_ignore("untyped_declaration")
	var sel = editor_selection.get_selected_nodes()
	
	if example_dialog != null:
		example_dialog.queue_free()
	
	if not sel.is_empty() and self == sel[0]:
		example_dialog = load("res://GUI/dialog_system/dialog_system.tscn").instantiate() as DialogSystemNode
		if example_dialog == null:
			return
		self.add_child(example_dialog)
		example_dialog.offset = _get_parent_global_position() + Vector2(16, -100)
		check_npc_data()
		_set_editor_display()

func _get_parent_global_position() -> Vector2:
	@warning_ignore("untyped_declaration")
	var p = self
	var _checking : bool = true
	while _checking == true:
		p = p.get_parent()
		if p:
			if p is Node2D:
				return p.global_position
		else:
			_checking = false
	return Vector2.ZERO
	
func _set_editor_display() -> void:
	pass
