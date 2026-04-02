class_name ItemData extends Resource

@export var name : String = ""
@export_multiline var description : String = ""
@export var texture : Texture2D
@export_range(1, 4, 0.1) var texture_scale : float = 1
@export var texture_modulate : Color = Color.WHITE
@export var audio : AudioStream
@export var heal_power : int = 0
@export var xp_amount : int = 0
