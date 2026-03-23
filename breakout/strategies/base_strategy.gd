class_name BaseStrategy extends Node


func decide(row : int, column : int, context : StrategyContext) -> StrategyResult:
	return null

func get_hp(row : int, context: StrategyContext) -> int:
	var max_hp = min(6, context.row_max - row)  
	return max(1, max_hp)
