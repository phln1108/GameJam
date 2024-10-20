extends Area2D

var draggable = preload("res://Scenes/draggable.tscn")

var on_bench: Dictionary = {}

func _on_craft_button_pressed() -> void:
	print("aa")
	for item in ItemManager.discovered_items.values():
		
		if item is Craftable:
			if len(item.craft_items) != len(on_bench.keys()):
				continue
			
			var craft = true
			for i in range(len(item.craft_items)):
				if not item.craft_items[i] in on_bench.keys() or on_bench[item.craft_items[i]] != item.craft_quantity[i]:
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
		
		#print(entered.item.name)

func _on_area_exited(area: Area2D) -> void:
	var exited = area.get_parent()
	if exited is Draggable:
		on_bench[exited.item.name] -= 1
		if on_bench[exited.item.name] == 0:
			on_bench.erase(exited.item.name)
		#print(exited.item.name)


func _on_crafting_visibility_changed() -> void:
	monitoring = $"..".visible
	monitorable = $"..".visible
