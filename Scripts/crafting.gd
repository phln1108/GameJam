extends Area2D

var draggable = preload("res://Scenes/draggable.tscn")

var on_bench: Dictionary = {}

# TODO: Verificar os itens no array para craftar

func _on_craft_button_pressed() -> void:
	for item in ItemManager.discovered_items.values():
		if item is Craftable:
			if len(item.craft_items) != len(on_bench.keys()):
				continue
			
			var craft = true
			for i in range(len(item.craft_items)):
				if not item.craft_items[i] in on_bench.keys() or on_bench[item.craft_items[i]] != item.craft_quantity[i]:
					print(item.name)
					craft = false
					break
			
			if not craft:
				continue
					
			craft_item(item)
			return

func craft_item(item: Craftable):
	for area in get_overlapping_areas():
		if area.get_parent() is Draggable:
			area.get_parent().queue_free()
	
	for material in on_bench.keys():
		ItemManager.inventory[material].quantity -= on_bench[material]
		
	ItemManager.inventory[item.name].quantity += item.output
	
	ItemManager.inventory_update.emit()
	
# Guarda os nomes dos itens on array

func _on_area_entered(area: Area2D) -> void:
	var entered = area.get_parent()
	if entered is Draggable:
		if entered.item.name in on_bench:
			on_bench[entered.item.name] += 1
		else:
			on_bench[entered.item.name] = 1
		
		print(entered.item.name)

func _on_area_exited(area: Area2D) -> void:
	var entered = area.get_parent()
	if entered is Draggable:
		on_bench[entered.item.name] -= 1
		print(entered.item.name)
