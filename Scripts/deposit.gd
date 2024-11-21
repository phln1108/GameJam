extends Area2D

@onready var sprite: = $Sprite2D
var animate: bool = false

var distortion_ratio: = 1.5
var distortion_step: = .25
	

func _process(delta: float) -> void:
	if not animate: 
		return
		
	sprite.scale += Vector2(0,distortion_step)
	if sprite.scale.x == sprite.scale.y:
		animate = false
		distortion_step *= -1
		return
	
	if absf(sprite.scale.x - sprite.scale.y) >= distortion_ratio:
		distortion_step *= -1

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
	if item.name in HistoryController.items_left_to_give.keys() and HistoryController.items_left_to_give[item.name] > 0:
		#removing item from inventory and lsit of requiring items
		HistoryController.items_left_to_give[item.name] -= 1
		HistoryController.gave_items[item.name] += 1
		HistoryController.update_item_to_give.emit()
		ItemManager.inventory[item.name].quantity -= 1
		
		#animation
		animate = true
		
		draggable.queue_free()
