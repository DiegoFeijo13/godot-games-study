@tool
class_name DialogBranch extends DialogItem

@export var text : String = "" : set = _set_text

var dialog_items : Array[DialogItem]

func _ready() -> void:
	super()
	if Engine.is_editor_hint():
		return
	
	for c in get_children():
		if c is DialogItem:
			dialog_items.append(c)

func _set_editor_display() -> void:
	@warning_ignore("untyped_declaration")
	var _p = get_parent()
	if _p is DialogChoice:
		_set_related_text()
		if _p.dialog_branches.size() < 2:
			return
		example_dialog.set_dialog_choice(_p as DialogChoice)
		
func _set_related_text() -> void:
	@warning_ignore("untyped_declaration")
	var _p = get_parent()
	@warning_ignore("untyped_declaration")
	var _p2 = _p.get_parent()
	@warning_ignore("untyped_declaration")
	var _t = _p2.get_child(_p.get_index()-1)
	
	if _t is DialogText:
		example_dialog.set_dialog_text(_t)
		example_dialog.content.visible_characters = -1

func _set_text(value : String) -> void:
	text = value
	if Engine.is_editor_hint() and example_dialog != null:
		_set_editor_display()
