class_name BrickContainer extends Node2D

const BRICK = preload("uid://bhwe0knkuj72h")

const NUM_COLUMNS = 7
const ROW_SIZE = 32
const COLUMN_SIZE = 128
const PATTERNS = ["wall", "chessboard", "fort", "triangle", "chaos"]

var last_pattern : String

func _ready() -> void:
	clear_container()
	load_bricks()
	GlobalGameState.bricks = get_children().size()
	GlobalEventBus.next_round.connect(on_next_round)

func clear_container() -> void:
	if get_children().size() > 0:
		for c in get_children():
			c.queue_free()

func load_bricks() -> void:		
	var bricks_hp = min(6, GlobalGameState.current_round)
	var rows = min(GlobalGameState.current_round + 2, 12)	
	
	var pattern = choose_pattern()
	
	match pattern:
		"wall":
			wall_pattern(bricks_hp, rows)
		"chessboard":
			chessboard_pattern(bricks_hp, rows)
		"fort":
			fort_pattern(bricks_hp, rows)
		"triangle":
			triangle_pattern(bricks_hp, rows)
		"chaos":
			chaos_pattern(bricks_hp, rows)
		
		

func wall_pattern(bricks_hp : int, rows : int) -> void:
	for r in rows:
		if r > 0 && (r % 2) == 0:
			bricks_hp = max(1, bricks_hp -1)
		for c in NUM_COLUMNS:
			_load_brick(r * ROW_SIZE, c * COLUMN_SIZE, bricks_hp)

func chessboard_pattern(bricks_hp : int, rows: int) -> void:	
	for r in rows:
		if r > 0 && (r % 2) == 0:
			bricks_hp = max(1, bricks_hp -1)
		for c in NUM_COLUMNS:
			if (r + c) % 2 == 0:
				_load_brick(r * ROW_SIZE, c * COLUMN_SIZE, bricks_hp)

func fort_pattern(bricks_hp : int, rows : int) -> void:	
	for r in rows:
		if r > 0 && (r % 2) == 0:
			bricks_hp = max(1, bricks_hp -1)
		for c in NUM_COLUMNS:
			if r == 0 || r == rows-1 || c == 0 || c == NUM_COLUMNS-1:
				_load_brick(r * ROW_SIZE, c * COLUMN_SIZE, bricks_hp)
			else:
				if randf() <= 0.3:
					_load_brick(r * ROW_SIZE, c * COLUMN_SIZE, bricks_hp)

func triangle_pattern(bricks_hp : int, rows : int) -> void:	
	for r in rows:
		if r > 0 && (r % 2) == 0:
			bricks_hp = max(1, bricks_hp -1)
		var center : int = NUM_COLUMNS / 2
		var min_column = center - r
		var max_column = center + r		
		for c in NUM_COLUMNS:
			if c > min_column && c <  max_column:
				_load_brick(r * ROW_SIZE, c * COLUMN_SIZE, bricks_hp)

func chaos_pattern(bricks_hp : int, rows : int) -> void:	
	for r in rows:
		if r > 0 && (r % 2) == 0:
			bricks_hp = max(1, bricks_hp -1)		
		for c in NUM_COLUMNS:
			if randf() <= 0.7:
				var hp = bricks_hp
				if randf() <= 0.2:
					hp = min(6, hp + 1)
				_load_brick(r * ROW_SIZE, c * COLUMN_SIZE, hp)

func choose_pattern() -> String:
	if GlobalGameState.current_round < PATTERNS.size():
		return PATTERNS[GlobalGameState.current_round -1]
		
	var rn = randi_range(0, PATTERNS.size() -1)
	return PATTERNS[rn]

func _load_brick(pos_y : float, pos_x : float, hp : int) -> void:
	var b = BRICK.instantiate() as Brick
	b.position.y = pos_y
	b.position.x = pos_x
	b.hp = hp
	add_child(b)

func on_next_round() -> void:
	clear_container()
	load_bricks()
