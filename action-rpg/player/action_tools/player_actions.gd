class_name PlayerAction extends Node2D

@onready var tool_boomerang: PlayerActionBoomerang = $Boomerang
@onready var tool_bow: PlayerActionBow = $Bow

var selected_tool : GlobalConstants.TOOL_TYPES
var player : Player

func _ready() -> void:
	player = GlobalPlayerManager.player
	GlobalEventBus.player_equip_tool.connect(_on_player_equip_tool)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("tool"):
		_act()

func _on_player_equip_tool(tool_type : GlobalConstants.TOOL_TYPES) -> void:
	selected_tool = tool_type

func _act() -> void:
	match selected_tool:
		GlobalConstants.TOOL_TYPES.BOOMERANG:
			tool_boomerang.act()
		GlobalConstants.TOOL_TYPES.BOMB:
			pass
		GlobalConstants.TOOL_TYPES.BOW:
			tool_bow.act()
