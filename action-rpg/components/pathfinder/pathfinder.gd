class_name Pathfinder extends Node2D

var vectors : Array[Vector2] =[
	Vector2.UP,
	Vector2.UP + Vector2.RIGHT,		
	Vector2.RIGHT,
	Vector2.DOWN + Vector2.RIGHT,
	Vector2.DOWN,
	Vector2.DOWN + Vector2.LEFT,
	Vector2.LEFT,
	Vector2.UP + Vector2.LEFT	
]

var interests : Array[float]
var obstacles : Array[float] = [0,0,0,0,0,0,0,0]
var outcomes : Array[float] = [0,0,0,0,0,0,0,0]
var rays : Array[RayCast2D]

var move_dir : Vector2 = Vector2.ZERO
var best_path : Vector2 = Vector2.ZERO

@onready var timer: Timer = $Timer

func _ready() -> void:
	# Gather all RayCast2D
	for c in get_children():
		if c is RayCast2D:
			rays.append(c)
	
	# Normalize all vectors
	for v in vectors:
		v = v.normalized()
	
	# Perform initial pathfinder function
	set_path()
	
	# Connect our timer
	timer.timeout.connect(set_path)
	pass

func _process(delta: float) -> void:
	move_dir = lerp(move_dir, best_path, 10 * delta) 

func set_path() -> void:
	# Get direction to the player
	var player_dir : Vector2 = global_position.direction_to(GlobalPlayerManager.player.global_position)
	
	# Reset obstacle and outcomes values to 0
	for i in 8:
		obstacles[i] = 0
		outcomes[i] = 0
	
	# Check each RayCast2D for collision & update values in obstacles array
	for i in 8:
		if rays[i].is_colliding():
			obstacles[i] += 4
			obstacles[(i + 1) % 8] += 1
			obstacles[(i - 1) % 8] += 1
	
	# If there are no obstacles, recommend path in direction of player
	if obstacles.max() == 0:
		best_path = player_dir
		return
	
	# Populate our interest array. This array contais values that represent
	# the desireability of each direction
	interests.clear()
	for v in vectors:
		interests.append(v.dot(player_dir))
	
	# Populate outcomes array, by combining interest and obstacle arrays
	for i in 8:
		outcomes[i] = interests[i] - obstacles[i]
	
	# Set the best path with the Vector2 that corresponds with the outcome with the highest value
	best_path = vectors[outcomes.find(outcomes.max())]
	pass
