@tool
class_name LevelTransition extends Area2D

enum SIDE { LEFT, RIGHT, TOP, BOTTOM }

@export_file("*.tscn") var level
@export var next_map_name : String
@export var target_position : Vector2 = Vector2.ZERO

@export_category("Collision Area Settings")

@export_range( 1, 12, 1, "or_greater") var size : int = 1 :
	set( _v ) : 
		size = _v
		_update_area()
		
@export var side : SIDE = SIDE.LEFT :
	set( _v ):
		side = _v
		_update_area()
		
@export var snap_to_grid : bool = false :
	set( _v ):
		snap_to_grid = _v
		_snap_to_grid()

@onready var collision_shape : CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	_update_area()
	if Engine.is_editor_hint():
		return
	
	body_entered.connect( _player_entered )
	pass

func _player_entered( _p : Node2D ) -> void:
	GlobalEventBus.load_new_scene.emit(level, target_position, next_map_name)

func _update_area() -> void:
	var new_rect : Vector2 = Vector2( 16, 16 )
	var new_position : Vector2 = Vector2.ZERO
	
	if side == SIDE.TOP:
		new_rect.x *= size
		new_position.y -= 8
	elif side == SIDE.BOTTOM:
		new_rect.x *= size
		new_position.y += 8
	elif side == SIDE.LEFT:
		new_rect.y *= size
		new_position.x -= 8	
	elif side == SIDE.BOTTOM:
		new_rect.y *= size
		new_position.x += 8
		
	if collision_shape == null:
		collision_shape = get_node("CollisionShape2D")	
		
	collision_shape.shape.size = new_rect	
	collision_shape.position = new_position

func _snap_to_grid() -> void:
	position.x = round( position.x / 8 ) * 8
