extends Control

@onready var container: ColorRect = $Container


var selling_items = []

func _ready() -> void:
	for i in range(container.get_child_count()):
		for j in range(container.get_child(i).get_child_count()):
			selling_items.append(container.get_child(i).get_child(j))
	
		
		
	for item in ItemManager.items:
		if item is Collectable:
			if item.price != 0:
				pass


func _process(delta: float) -> void:
	pass
