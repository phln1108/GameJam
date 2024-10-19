extends Node

# todos os itens
var items: Array[Item]

# itens discorbertos
var discovered_items: Array[Item] = []

# inventario:
# nome_do_item : {
#	item: Item,
#	quantity: int,
#}
var inventory: Dictionary = {}

func _ready() -> void:
	items = ItemParser.get_json_data()
	discovered_items = []
	for item in items:
		discover_item(item)

func discover_item(discovered_item: Item) -> void:
	discovered_items.append(discovered_item)
	
	inventory[discovered_item.name] = {
		"item": discovered_item,
		"quantity": 1
	}
