class_name BrickStateDestroy extends BrickState

const POWER_UP = preload("uid://ucwckrfcd81")
const POWER_UP_TYPES = [
	PowerUp.Power_Type.OneUp,
	PowerUp.Power_Type.ExtraBall,
	PowerUp.Power_Type.Slow	
]

func init() -> void:
	brick.brick_destroyed.connect(on_brick_destroyed)

func enter() -> void:
	_drop_power_up()
	brick.invunerable = true
	brick.queue_free()
	GlobalEventBus.update_score.emit(brick.score)

func exit() -> void:
	pass

func process(_d : float) -> BrickState:
	return null

func on_brick_destroyed() -> void:
	state_machine.change_state(self)

func _drop_power_up() -> void:
	if GlobalGameState.has_power_up_on_screen:
		return
	
	var r = randf()
	if r > GlobalGameState.current_power_up_chance(): 
		return
	
	var t = randi_range(0, POWER_UP_TYPES.size()-1)
	var drop := POWER_UP.instantiate() as PowerUp
	drop.type = POWER_UP_TYPES[t]
	brick.get_parent().call_deferred("add_child", drop) 
	drop.position = brick.position
	
	GlobalEventBus.power_up_spawn.emit()
	
