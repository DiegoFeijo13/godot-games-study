class_name InventoryData extends Resource

@export var upgrades : Array[SlotData]

func _init() -> void:	
	pass

func add_upgrade(item : UpgradeData) -> void:
	for u in upgrades:
		if u && u.upgrade_data == item:
			u.quantity += 1
			return
	
	var new = SlotData.new()
	new.upgrade_data  = item
	new.quantity = 1
	upgrades.append(new)
	new.changed.connect(slot_changed)

func slot_changed() -> void:
	for u in upgrades:
		if u and u.quantity < 1:
			u.changed.disconnect(slot_changed)
			var index = upgrades.find(u)
			upgrades[index] = null
			emit_changed()
