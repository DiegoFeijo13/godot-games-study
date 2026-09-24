class_name PlayerInventoryData extends Resource

@export var tools : Dictionary[GlobalConstants.TOOL_TYPES, InventoryToolData]

const START_MAX_HP : int = 6
const MAX_GOLD : int = 9999
const MAX_KEY_COUNT : int = 99

var current_hp : int = 0
var max_hp : int = 6
var current_gold : int = 0
var current_key_count : int = 0

var sword_equip : EquipData
var armor_equip : EquipData
var shield_equip : EquipData

var tool_equip : InventoryToolData

# Tools counts
var current_arrow_max : int = 20
var current_arrow_count : int = 0

func update_hp(delta : int) -> void:
	current_hp = clampi(current_hp + delta, 0, max_hp)

func update_gold(delta : int) -> void:
	current_gold = clampi(current_gold + delta, 0, MAX_GOLD)

func update_key(delta : int) -> void:
	current_key_count = clampi(current_key_count + delta, 0, MAX_KEY_COUNT)

func update_arrow(delta : int) -> void:
	current_arrow_count = clampi(current_arrow_count + delta, 0, current_arrow_max)

func equip_sword(new_sword : EquipData) -> void:
	sword_equip = new_sword

func equip_armor(new_armor : EquipData) -> void:
	armor_equip = new_armor

func add_tool(new_tool : ToolData) -> void:
	# check if tool exists
	if tools and tools.has(new_tool.type):
		return
	
	var inventory_tool_data : InventoryToolData = InventoryToolData.new()
	inventory_tool_data.tool_data = new_tool
	
	tools.get_or_add(new_tool.type, inventory_tool_data)

func equip_tool(tool_data : ToolData) -> void:
	if tool_data == null or tools.has(tool_data.type) == false:
		return
	
	tool_equip = tools.get(tool_data.type)
	GlobalEventBus.player_equip_tool.emit(tool_data.type)
