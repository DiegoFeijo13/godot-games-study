class_name PlayerHUD extends Node

var hearts : Array[HeartGUI] = []

func _ready() -> void:
	for child in $Control/HFlowContainer.get_children():
		if child is HeartGUI:
			hearts.append(child)
			child.visible = false
	GlobalEventBus.player_hp_updated.connect(_on_player_hp_updated)

func _on_player_hp_updated(current_hp : int, max_hp : int) -> void:
	update_max_hp(max_hp)	
	for i in max_hp:
		update_heart(i, current_hp)

func update_heart( _index : int, _hp : int)  -> void:
	var _value : int = clampi( _hp - _index * 2, 0, 2 )
	hearts[_index].value = _value 	

func update_max_hp( _max_hp : int) -> void:
	var _heart_count : int = roundi( _max_hp * 0.5 )
	for i in hearts.size():		
		hearts[i].visible = i < _heart_count
