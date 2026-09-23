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
	disable_all()
	update_tool_slot(boomerang, "Boomerang", true)
	update_tool_slot(bomb, "Bomb")
	update_tool_slot(bow_n_arrow, "Bow")
	update_tool_slot(candle, "Candle")
	update_tool_slot(flute, "Flute")
	update_tool_slot(meat, "Meat")
	update_tool_slot(letter, "Letter")
	update_tool_slot(rod, "Rod")
	

func disable_all() -> void:
	set_disabled(boomerang)
	set_disabled(bomb)
	set_disabled(bow_n_arrow)
	set_disabled(candle)
	set_disabled(flute)
	set_disabled(meat)
	set_disabled(letter)
	set_disabled(rod)

func set_disabled(btn : Button) -> void:
	btn.disabled = true
	btn.focus_mode = Control.FOCUS_NONE

func set_enabled(btn : Button) -> void:
	btn.disabled = false
	btn.focus_mode = Control.FOCUS_ALL

func update_tool_slot(slot : ToolSlotUI, tool_name : String, force_focus_when_no_equip : bool = false) -> void:
	var tools_dic := GlobalPlayerManager.inventory.tools
	
	if tools_dic.has(tool_name) == false:
		return
	
	var equiped_tool := GlobalPlayerManager.inventory.tool_equip
	var inventory_tool_data := tools_dic.get(tool_name) as InventoryToolData
	slot.set_slot_data(inventory_tool_data.tool_data)
	set_enabled(slot)
	
	if equiped_tool == null and force_focus_when_no_equip:
		slot.grab_focus.call_deferred()
		return
	
	if equiped_tool and equiped_tool.tool_data.name == inventory_tool_data.tool_data.name:
		slot.grab_focus.call_deferred()
