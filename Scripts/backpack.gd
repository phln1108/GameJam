extends Control

var item_drag = preload("res://Scenes/itemContainer.tscn")

var is_dragging := false
var ancor: Vector2
var last_scroll_value: int 

func _ready() -> void:
	populate_backpack()
	
	ItemManager.inventory_update.connect(populate_backpack)
	
	#tirar a scrollbar do scroll_container
	var scroll_container = $ScrollContainer
	var theme = Theme.new()
	if not theme.has_stylebox("scroll", "ScrollBar"):
		theme.set_stylebox("scroll", "ScrollBar", StyleBox.new())
	theme.set_constant("scroll_size", "ScrollBar", 20)  # Example: 20 pixels width
	scroll_container.theme = theme

func populate_backpack() -> void:
	for node in $ScrollContainer/VBoxContainer.get_children():
		$ScrollContainer/VBoxContainer.remove_child(node)
		node.queue_free() 
		
	for item in ItemManager.inventory.values():
		if item.quantity == 0:
			continue
		var item_draggable = item_drag.instantiate()
		item_draggable.item = item["item"]
		item_draggable.quantity = item["quantity"]
		$ScrollContainer/VBoxContainer.add_child(item_draggable)


func _input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and $ScrollContainer.get_rect().has_point(event.position):
				is_dragging = true
				ancor = get_global_mouse_position()
				last_scroll_value = $ScrollContainer.scroll_horizontal
				accept_event()
		else:
			is_dragging = false
			
func _physics_process(delta: float) -> void:
	if is_dragging:
		$ScrollContainer.scroll_horizontal = (ancor - get_global_mouse_position()).x + last_scroll_value


func _on_area_entered(area: Area2D) -> void:
	if area.get_parent() is Draggable:
		(area.get_parent() as Draggable).stop_dragging.connect(_on_item_return)


func _on_area_exited(area: Area2D) -> void:
	if area.get_parent() is Draggable:
		(area.get_parent() as Draggable).stop_dragging.disconnect(_on_item_return)

func _on_item_return(draggable: Draggable) -> void:
	draggable.returned.emit()
	draggable.queue_free()
