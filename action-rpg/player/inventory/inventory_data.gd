class_name PlayerInventoryData extends Resource

const START_MAX_HP : int = 6

var current_hp : int = 0
var max_hp : int = 6

func update_hp(delta : int) -> void:
	current_hp = clampi(current_hp + delta, 0, max_hp)
