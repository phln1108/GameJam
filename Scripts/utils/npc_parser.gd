extends Node
class_name NpcParser

static var item_json_path: String = "res://TextResources/npcs.json"

static func get_json_data() ->  Array[Npc]:
	var npcs: Array[Npc] = []
	
	if not FileAccess.file_exists(item_json_path):
		printerr("error reading file")
		return []
		
	var data_file := FileAccess.open(item_json_path,FileAccess.READ)
	var parsed_results: Dictionary = JSON.parse_string(data_file.get_as_text())
	
	for parsed_npc in parsed_results["npcs"]:
		var npc := Npc.new()
		npc.image = parsed_npc["image"]
		npc.start_dialogue = parsed_npc["start_dialogue"]
		npc.no = parsed_npc["no"]
		npc.yes = parsed_npc["yes"]
		npc.items = parsed_npc["items"]
		npc.weight = parsed_npc["weight"]
		npc.quantity = parsed_npc["quantity"]
		npc.brought_items = parsed_npc["brought_items"]
		npc.brought_items_quantity = parsed_npc["brought_items_quantity"]
		print(npc.weight)
		npcs.append(npc)
	
	return npcs
