class_name ChaosStrategy extends BaseStrategy

func decide(row : int, column: int, context: StrategyContext) -> StrategyResult:	
	var result = StrategyResult.new()
	result.hp = get_hp(row, context)
	result.spawn = randf() <= 0.7
	return result
