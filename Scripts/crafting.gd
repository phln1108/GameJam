extends Area2D

var on_bench: Dictionary = {}

# TODO: Verificar os itens no array para craftar

func _on_craft_button_pressed() -> void:
	for item in ItemManager.items:
		if item is Craftable:
			pass # TODO: verificar os itens necessarios para craftar		



# Guarda os nomes dos itens on array

func _on_area_entered(area: Area2D) -> void:
	var entered = area.get_parent()
	if entered is Draggable:
		if area.get_parent().name in on_bench:
			on_bench[area.get_parent().item.name] += 1
		else:
			on_bench[area.get_parent().item.name] = 1
		
		print(area.get_parent().item.name)

func _on_area_exited(area: Area2D) -> void:
	var entered = area.get_parent()
	if entered is Draggable:
		on_bench[area.get_parent().item.name] -= 1
		print(area.get_parent().item.name)
