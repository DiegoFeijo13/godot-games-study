class_name UpgradePool extends Node

const EPIC_PROB : float = 0.01
const RARE_PROB : float = 0.1
const UNCOMMON_PROB : float = 0.5
const COMMON_PROB : float = 1.0

@export var epic_upgrades : Array[UpgradeData] = []
@export var rare_upgrades : Array[UpgradeData] = []
@export var uncommon_upgrades : Array[UpgradeData] = []
@export var common_upgrades : Array[UpgradeData] = []

var _upgrades_drawn : Array[UpgradeData] = []
var _categories_drawn : Array[UpgradeData.UpgradeCategory] = []

func _ready() -> void:
	GlobalEventBus.level_up.connect(_on_level_up)

func _on_level_up(_levels_gained : int, _current_level : int) -> void:
	_upgrades_drawn = []
	_categories_drawn = []
	
	_draw(_draw_pool())
	_draw(_draw_pool())
	_draw(_draw_pool())
	
	GlobalEventBus.update_upgrade_choices.emit(_upgrades_drawn)

func _draw_pool() -> Array[UpgradeData]:
	var prob = randf()
	if prob <= EPIC_PROB:
		return epic_upgrades
	if prob <= RARE_PROB:
		return rare_upgrades
	if prob <= UNCOMMON_PROB:
		return uncommon_upgrades
	return common_upgrades

func _draw(pool : Array[UpgradeData]) -> void:
	if pool == null or pool.size() == 0:
		return
	
	pool.shuffle()
	
	for i in pool.size():
		if pool[i] == null:
			continue
		
		if _categories_drawn.size() > 0 and _categories_drawn.has(pool[i].category):
			continue
				
		_categories_drawn.append(pool[i].category)
		_upgrades_drawn.append(pool[i])
		return
