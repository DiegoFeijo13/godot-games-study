class_name DropTableData extends Resource

@export var items : Array[DropData]

func get_drop() -> ItemDropData:
	var item_drop_data : ItemDropData = null
	
	if items.size() == 0:
		return item_drop_data
	
	for i in items.size():
		if items[i] == null or items[i].item_drop_data == null:
			continue
		if items[i].get_drop():
			item_drop_data = items[i].item_drop_data
			break
	
	return item_drop_data
