class_name Level extends Node

const NUM_COLUMNS = 7
const ROW_SIZE = 32
const COLUMN_SIZE = 128
const BRICK = preload("uid://bhwe0knkuj72h")
const BALL = preload("uid://c2hv7s8x1poll")

@onready var bricksContainer: Node2D = $BricksContainer

var bricks_loaded : int

func _ready() -> void:
	GlobalEventBus.next_round.connect(_on_next_round)
	GlobalEventBus.spawn_extra_ball.connect(_on_spawn_extra_ball)
	GlobalEventBus.ball_lost.connect(_on_ball_lost)
	GlobalEventBus.next_round.emit()
	_spawn_ball()

func _on_next_round() -> void:
	_clear_container()
	_remove_balls()
	_spawn_ball()
	_execute_strategy()
	GlobalGameState.bricks = bricks_loaded

func _spawn_ball() -> void:
	var ball = BALL.instantiate() as Ball
	call_deferred("add_child", ball)

func _remove_balls() -> void:	
	for c in get_children():
		if c is Ball:
			c.queue_free()
	
func _execute_strategy() -> void:
	bricks_loaded = 0	
	var strategy = GlobalGameState.current_strategy
	var context := _build_context()
	for r in context.row_max:
		for c in NUM_COLUMNS:
			var result := strategy.decide(r,c,context)
			if result.spawn:
				bricks_loaded += 1
				_load_brick(r * ROW_SIZE, c * COLUMN_SIZE, result.hp)
	pass

func _build_context() -> StrategyContext:
	var context = StrategyContext.new()
	context.col_max = NUM_COLUMNS
	context.row_max = min(GlobalGameState.current_round + 2, 12)
	context.current_round = GlobalGameState.current_round	
	return context

func _clear_container() -> void:
	if bricksContainer.get_children().size() > 0:
		for c in bricksContainer.get_children():
			c.queue_free()

func _load_brick(pos_y : float, pos_x : float, hp : int) -> void:
	var b = BRICK.instantiate() as Brick
	b.position.y = pos_y
	b.position.x = pos_x
	b.hp = hp
	bricksContainer.call_deferred("add_child",b)

func _on_spawn_extra_ball() -> void:
	_spawn_ball()

func _on_ball_lost() -> void:
	for b in get_children():
		if b is Ball && !b.is_queued_for_deletion():
			return
	# no ball found
	GlobalEventBus.life_lost.emit()
	_spawn_ball()
	
