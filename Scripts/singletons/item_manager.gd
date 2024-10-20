extends Node

signal inventory_update

# todos os itens
var items: Array[Item]

# itens discorbertos:
# nome_do_item : item
var discovered_items: Dictionary = {}

# inventario:
# nome_do_item : {
#	item: Item,
#	quantity: int,
#}
var inventory: Dictionary = {}
	

func _ready() -> void:
	items = ItemParser.get_json_data()
	discover_item(items[0])
	discover_item(items[1])
	discover_item(items[2])
	discover_item(items[3])
	discover_item(items[7])
	#for item in items:
		#discover_item(item)

func discover_item(discovered_item: Item) -> void:
	if discovered_item.name in discovered_items.keys(): 
		return
		
	discovered_items[discovered_item.name] = discovered_item
		
	inventory[discovered_item.name] = {
		"item": discovered_item,
		"quantity": 10
	}
