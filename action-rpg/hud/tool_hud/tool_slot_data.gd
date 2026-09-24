class_name ToolSlotData extends Resource

@export var item_data : ToolData
@export var quantity : int = 0 : set = set_quantity

func set_quantity( value : int ) -> void:
	quantity = value
	if quantity < 1:
		emit_changed()
