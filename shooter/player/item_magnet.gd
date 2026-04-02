class_name ItemMagnet extends Area2D

var items : Array[Drop] = []
var speeds : Array[float] = []

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var magnet_strength : float = 2.0
@export var magnet_radius : float = 32.0

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	(collision_shape_2d.shape as CircleShape2D).radius = magnet_radius

func _process(_d : float) -> void:
	for i in range(items.size() -1, -1, -1): #loop in reverse
		var _item = items[i]
		if _item == null:
			items.remove_at(i)
			speeds.remove_at(i)
		elif _item.global_position.distance_to(global_position) > speeds[i]:
			speeds[i] += magnet_strength * _d
			_item.position += _item.global_position.direction_to(global_position) * speeds[i]
		else:
			_item.global_position = global_position

func _on_area_entered(_a : Area2D) -> void:
	if _a.get_parent() is Drop:
		var new_item = _a.get_parent() as Drop
		items.append(new_item)
		speeds.append(magnet_strength)
		new_item.set_physics_process(false)
