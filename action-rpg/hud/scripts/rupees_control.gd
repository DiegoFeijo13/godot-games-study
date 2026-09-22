class_name RupeesControl extends Control

@onready var thousands: Sprite2D = $Thousands
@onready var hundreds: Sprite2D = $Hundreds
@onready var tens: Sprite2D = $Tens
@onready var units: Sprite2D = $Units

func _ready() -> void:
	GlobalEventBus.player_gold_updated.connect(update_rupees)

func update_rupees(value : int) -> void:
	var digits : Array[int] = []
	var temp_value : int = value
	
	while temp_value > 0:
		digits.append(temp_value % 10)
		@warning_ignore("integer_division")
		temp_value = temp_value / 10
	
	thousands.frame = 0
	hundreds.frame = 0
	tens.frame = 0
	units.frame = 0
	
	if digits.size() >= 1:
		units.frame = digits[0]
	if digits.size() >= 2:
		tens.frame = digits[1]
	if digits.size() >= 3:
		hundreds.frame = digits[2]
	if digits.size() >= 4:
		thousands.frame = digits[3]
