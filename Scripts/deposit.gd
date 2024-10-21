extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	var parent := area.get_parent()
	if parent is Draggable:
		parent.stop_dragging.connect(verify_item)
		


func _on_area_exited(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent is Draggable:
		parent.stop_dragging.disconnect(verify_item)
		
func verify_item(draggable: Draggable):
	var item = draggable.item
	print(item.name in HistoryController.items_left_to_give.keys())
	if item.name in HistoryController.items_left_to_give.keys():
		HistoryController.items_left_to_give[item.name] -= 1
		HistoryController.gave_items[item.name] += 1
		HistoryController.update_item_to_give.emit()
		ItemManager.inventory[item.name].quantity -= 1
		
		draggable.queue_free()
