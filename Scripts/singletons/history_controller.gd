extends Node

signal update_item_to_give
signal item_to_give_updated
signal requirements_completed
signal requirements_refused
signal get_items_from_npc
signal new_npc

var refused_offers: int = 0
var completed_offers: int = 0

var npc_count: int = 0 :
	set(value):
		npc_count = value

#todos os npc's
var npcs: Array[Npc] = []

var current_npc: Npc = null
var items_left_to_give: Dictionary = {}
var gave_items: Dictionary = {}

var limit := 1

# -1: portugueses
# +1: indios
# indios win > > neutro >  > portugueses win
var wheight: int = 0
		

func _ready() -> void:
	npcs = NpcParser.get_json_data()
	update_item_to_give.connect(verify_items_to_give)
	requirements_refused.connect(_on_requirements_refused)
	get_items_from_npc.connect(_on_get_item_npc)

func get_random_npc() -> void:
	if len(npcs) == 0:
		printerr("cabo npc")
		return
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(0, len(npcs) -1)
	
	#current_npc = npcs.pop_at(num)
	current_npc = npcs[num]
	
	gave_items = {}
	items_left_to_give = {}
	for i in range(len(current_npc.items)):
		items_left_to_give[current_npc.items[i]] = current_npc.quantity[i]
		gave_items[current_npc.items[i]] = 0
	
	print(gave_items)
	if abs(wheight) < limit: 
		new_npc.emit()
	else:
		Ending.finish()
	
func verify_items_to_give() -> void:
	for quantity in items_left_to_give.values():
		if quantity > 0: #completou
			item_to_give_updated.emit()
			return
	
	#completou
	completed_offers +=1
	wheight += current_npc.weight
	print("peso ", wheight)
	requirements_completed.emit()

func _on_requirements_refused() -> void:
	for item in gave_items.keys():
		ItemManager.inventory[item].quantity += gave_items[item]
	ItemManager.inventory_update.emit()
	wheight -= current_npc.weight
	print("peso ", wheight)
	refused_offers +=1

func _on_get_item_npc():
	for i in range(len(current_npc.brought_items)):
		ItemManager.inventory[current_npc.brought_items[i]].quantity += current_npc.brought_items_quantity[i]
