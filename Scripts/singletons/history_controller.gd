extends Node

signal update_item_to_give
signal new_npc

var npc_count: int = 0 :
	set(value):
		npc_count = value

#todos os npc's
var npcs: Array[Npc] = []
var talked_npcs: Array[Npc] = []

var current_npc: Npc = null
var items_left_to_give: Dictionary = {}
var gave_items: Dictionary = {}

# -1: portugueses
# +1: indios
# indios win > .5 > neutro > -.5 > portugueses win
var wheight = 0

func _ready() -> void:
	npcs = NpcParser.get_json_data()
	#get_random_npc()


func get_random_npc() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(0, len(npcs) -1)
	
	current_npc = npcs.pop_at(num)
	
	gave_items = {}
	items_left_to_give = {}
	for i in range(len(current_npc.items)):
		items_left_to_give[current_npc.items[i]] = current_npc.quantity[i]
	new_npc.emit()
