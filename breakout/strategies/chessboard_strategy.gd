class_name ChessboardStrategy extends BaseStrategy

func decide(row : int, column: int, context: StrategyContext) -> StrategyResult:	
	var result = StrategyResult.new()
	result.hp = get_hp(row, context)
	result.spawn = false
	if (row + column) % 2 == 0:
		result.spawn = true
	return result
