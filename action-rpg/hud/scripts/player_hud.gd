class_name PlayerHUD extends Node

const RUPEES_START_POS : Vector2 = Vector2(-48.0, 40.0)
const RUPEES_END_POS : Vector2 = Vector2(8.0, 40.0)

var hearts : Array[HeartGUI] = []
var show_rupees : bool = false

@onready var rupees: RupeesControl = $Control/Rupees
@onready var rupees_timer: Timer = $Control/RupeesTimer

func _ready() -> void:
	for child in $Control/HFlowContainer.get_children():
		if child is HeartGUI:
			hearts.append(child)
			child.visible = false
	GlobalEventBus.player_hp_updated.connect(_on_player_hp_updated)
	GlobalEventBus.player_gold_updated.connect(_on_player_gold_updated)
	rupees_timer.timeout.connect(_on_rupees_timer_timeout)

func _process(_delta: float) -> void:
	if show_rupees:
		rupees.position = rupees.position.move_toward(RUPEES_END_POS, 4)
		if rupees.position >= RUPEES_END_POS:
			show_rupees = false
			rupees_timer.start()

func _on_player_hp_updated(current_hp : int, max_hp : int) -> void:
	update_max_hp(max_hp)	
	for i in max_hp:
		update_heart(i, current_hp)

func _on_player_gold_updated(current_gold : int) -> void:
	rupees.update_rupees(current_gold)
	show_rupees = true
	rupees.visible = true

func _on_rupees_timer_timeout() -> void:
	rupees_timer.stop()
	show_rupees = false
	rupees.visible = false
	rupees.position = RUPEES_START_POS

func update_heart( _index : int, _hp : int)  -> void:
	var _value : int = clampi( _hp - _index * 2, 0, 2 )
	hearts[_index].value = _value 	

func update_max_hp( _max_hp : int) -> void:
	var _heart_count : int = roundi( _max_hp * 0.5 )
	for i in hearts.size():		
		hearts[i].visible = i < _heart_count
