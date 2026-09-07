class_name Constants extends Node

const DIR_4 : Array[Vector2] = [
	Vector2.RIGHT, 
	Vector2.DOWN, 
	Vector2.LEFT, 
	Vector2.UP
]
const DIR_8 : Array[Vector2] = [
	Vector2.UP,
	Vector2(1,-1), #RIGHT-UP
	Vector2.RIGHT, 
	Vector2(1,1), #RIGHT-DOWN
	Vector2.DOWN, 
	Vector2(-1,0), #LEFT-DOWN
	Vector2.LEFT,
	Vector2(-1,-1) #LEFT-UP 
]

func translate_to_dir4(direction : Vector2, cardinal_direction : Vector2) -> Vector2:
	# bias the direction by the cardinal_direction
	var direction_id : int = int( round( 
			(direction + cardinal_direction * 0.1).angle() 
			/ TAU * GlobalContants.DIR_4.size() 
	) )	
	
	return GlobalContants.DIR_4[ direction_id ]

func get_random_dir8() -> Vector2:
	var i : int = randi_range(0, DIR_8.size()-1)
	return DIR_8[i]
