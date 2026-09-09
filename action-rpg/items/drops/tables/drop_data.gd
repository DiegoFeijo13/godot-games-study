class_name DropData extends Resource

@export var item_drop_data : ItemDropData
@export_range(0, 100, 1, "suffix:%") var chance : float

func get_drop() -> bool:
	return randf_range(0,100) <= chance
