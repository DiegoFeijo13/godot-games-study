class_name ToolSlotUI extends Button

var tool_data : ToolData

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label

func _ready() -> void:
	texture_rect.texture = null
	label.text = ""
	focus_entered.connect(_on_focus_entered)
	focus_exited.connect(_on_focus_exited)

func set_slot_data(value : ToolData, quantity : int = 0) -> void:
	tool_data = value
	if tool_data == null:
		return
		
	texture_rect.texture = tool_data.texture
	
	if tool_data.is_unique == false and quantity == 0 and tool_data.when_zero_texture:
		texture_rect.texture = tool_data.when_zero_texture
	
	label.text = str(quantity)
	if quantity <= 0:
		label.visible = false	
	
	
func _on_focus_entered() -> void:
	if tool_data != null:
		GlobalPauseMenu.update_item_description(tool_data.name)
		GlobalPlayerManager.inventory.equip_tool(tool_data)

func _on_focus_exited() -> void:
	GlobalPauseMenu.update_item_description("")
