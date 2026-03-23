class_name FortStrategy extends BaseStrategy

func decide(row : int, column: int, context: StrategyContext) -> StrategyResult:	
	var result = StrategyResult.new()
	result.hp = get_hp(row, context)
	result.spawn = false
	if row ==0 || row == context.row_max -1 || column == 0 || column == context.col_max-1:
		result.spawn = true
	else:
		if randf() <= 0.3:
			result.spawn = true	
	return result
