class_name InventoryData extends Resource

@export var upgrades : Array[SlotData]

func _init() -> void:	
	pass

func add_upgrade(item : UpgradeData) -> bool:
	for u in upgrades:
		if u && u.upgrade_data == item:
			u.quantity += 1
			return true
	
	for i in upgrades.size():
		if upgrades[i] == null:
			var new = SlotData.new()
			new.item_data = item
			new.quantity = 1
			upgrades[i] = new
			new.changed.connect(slot_changed)
			return true
	
	print("inventory was full")
	return false

func slot_changed() -> void:
	for u in upgrades:
		if u and u.quantity < 1:
			u.changed.disconnect(slot_changed)
			var index = upgrades.find(u)
			upgrades[index] = null
			emit_changed()
