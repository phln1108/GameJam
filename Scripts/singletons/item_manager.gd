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
	for i in range(9):
		discover_item(items[i],5)
		
	for item in items:
		discover_item(item)

func discover_item(discovered_item: Item,quantity: int = 0) -> void:
	if discovered_item.name in discovered_items.keys(): 
		return
	
	discovered_items[discovered_item.name] = discovered_item
	inventory[discovered_item.name] = {
		"item": discovered_item,
		"quantity": quantity
	}
