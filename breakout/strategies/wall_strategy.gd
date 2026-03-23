class_name WallStrategy extends BaseStrategy

func decide(row : int, column: int, context: StrategyContext) -> StrategyResult:	
	var result = StrategyResult.new()
	result.hp = get_hp(row, context)
	result.spawn = true
	return result
