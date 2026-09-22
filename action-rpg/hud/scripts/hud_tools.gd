class_name HudTools extends Control

@onready var boomerang: ToolSlotUI = $PanelContainer/GridContainer/Boomerang
@onready var bomb: ToolSlotUI = $PanelContainer/GridContainer/Bomb
@onready var bow_n_arrow: ToolSlotUI = $PanelContainer/GridContainer/BowNArrow
@onready var candle: ToolSlotUI = $PanelContainer/GridContainer/Candle
@onready var flute: ToolSlotUI = $PanelContainer/GridContainer/Flute
@onready var meat: ToolSlotUI = $PanelContainer/GridContainer/Meat
@onready var letter: ToolSlotUI = $PanelContainer/GridContainer/Letter
@onready var rod: ToolSlotUI = $PanelContainer/GridContainer/Rod

func update_tools() -> void:
	var tools_dic := GlobalPlayerManager.inventory.tools
	var equiped_tool := GlobalPlayerManager.inventory.tool_equip
	
	if tools_dic.has("Boomerang"):
		var inventory_tool_data := tools_dic.get("Boomerang") as InventoryToolData
		boomerang.set_slot_data(inventory_tool_data.tool_data)
		boomerang.disabled = false	
		if equiped_tool and equiped_tool.tool_data.name == inventory_tool_data.tool_data.name:
			boomerang.grab_focus.call_deferred()
	
	if tools_dic.has("Bomb"):
		var inventory_tool_data := tools_dic.get("Bomb") as InventoryToolData
		bomb.set_slot_data(inventory_tool_data.tool_data)
		bomb.disabled = false
		
