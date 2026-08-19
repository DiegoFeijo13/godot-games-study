class_name PlayerInventoryData extends Resource

@export var items : Array[InventoryItemData]

const START_MAX_HP : int = 6

var current_hp : int = 0
var max_hp : int = 6

var action_one_equip : InventoryItemData

func update_hp(delta : int) -> void:
	current_hp = clampi(current_hp + delta, 0, max_hp)

func equip_action_one(index : int) -> void:
	if items.size() -1 < index:
		return
	action_one_equip = items[index]
