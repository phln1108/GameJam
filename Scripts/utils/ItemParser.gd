extends Node
class_name ItemParser

static var item_json_path: String = "res://TextResources/items.json"

static func get_json_data() -> Array[Item]:
	var items: Array[Item] = []
	
	if not FileAccess.file_exists(item_json_path):
		printerr("error reading file")
		return []
	
	var data_file := FileAccess.open(item_json_path,FileAccess.READ)
	var parsed_results: Dictionary = JSON.parse_string(data_file.get_as_text())
	
	for parsed_item in parsed_results["collectables"]:
		var item := Collectable.new()
		item.id = parsed_item["id"]
		item.name = parsed_item["name"]
		item.image = parsed_item["image"]
		item.description = parsed_item["description"]
		items.append(item)
	
	for parsed_item in parsed_results["craftables"]:
		var item := Craftable.new()
		item.id = parsed_item["id"]
		item.name = parsed_item["name"]
		item.image = parsed_item["image"]
		item.description = parsed_item["description"]
		item.craft_items = parsed_item["craft_items"]
		item.craft_quantity = parsed_item["craft_quantity"]
		item.know = parsed_item["know"]
		items.append(item)
	
	return items
