class_name TriangleStrategy extends BaseStrategy

func decide(row : int, column: int, context: StrategyContext) -> StrategyResult:	
	var result = StrategyResult.new()
	result.hp = get_hp(row, context)
	result.spawn = false
	var center : int = context.col_max / 2
	var min_column = center - row
	var max_column = center + row
	if column >= min_column && column <= max_column:
		result.spawn = true
	return result
