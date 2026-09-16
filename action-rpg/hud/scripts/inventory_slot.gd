class_name InventorySlotUI extends Button

var slot_data : SlotData : set = set_slot_data

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label

func _ready() -> void:
	texture_rect.texture = null
	label.text = ""
	focus_entered.connect(_on_focus_entered)
	focus_exited.connect(_on_focus_exited)

func set_slot_data(value : SlotData) -> void:
	slot_data = value
	if slot_data == null:
		return
	texture_rect.texture = slot_data.item_data.texture
	label.text = str(slot_data.quantity)
	
func _on_focus_entered() -> void:
	if slot_data != null && slot_data.item_data != null:
		GlobalPauseMenu.update_item_description(slot_data.item_data.description)

func _on_focus_exited() -> void:
	GlobalPauseMenu.update_item_description("")
