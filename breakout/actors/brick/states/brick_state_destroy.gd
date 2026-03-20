class_name BrickStateDestroy extends BrickState


func init() -> void:
	brick.brick_destroyed.connect(on_brick_destroyed)

func enter() -> void:
	brick.invunerable = true
	brick.queue_free()
	GlobalEventBus.update_score.emit(brick.score)

func exit() -> void:
	pass

func process(_d : float) -> BrickState:
	return null

func on_brick_destroyed() -> void:
	state_machine.change_state(self)
