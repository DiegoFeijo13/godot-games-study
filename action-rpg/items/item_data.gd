class_name ItemData extends Resource

@export var name : String = ""
@export_multiline var description : String = ""
@export var texture : Texture2D
@export var audio : AudioStream
@export var heal_power : int = 0
@export var gold_amount : int = 0
@export var is_unique : bool = false
@export var player_state_name : String = "Idle"
