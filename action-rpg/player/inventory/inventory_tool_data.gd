class_name InventoryToolData extends Resource

@export var tool_data : ToolData
@export var quantity : int = 0 : set = set_quantity

func set_quantity(value : int) -> void:
	if tool_data.is_unique:
		return
	quantity = value
	if quantity < 1:
		emit_changed()
