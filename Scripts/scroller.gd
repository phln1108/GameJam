extends Control

var item_drag = preload("res://Scenes/itemContainer.tscn")




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for item in ItemManager.inventory.values():
		var item_draggable = item_drag.instantiate()
		item_draggable.item = item["item"]
		item_draggable.quantity = item["quantity"]
		$ScrollContainer/VBoxContainer.add_child(item_draggable)
		
	print($ScrollContainer/VBoxContainer.get_child_count())
	
	# Ensure that the ScrollContainer node exists and is properly referenced
	var scroll_container = $ScrollContainer
	
	# Create a new theme
	var theme = Theme.new()

	# Check if the ScrollBar style exists, otherwise create it
	if not theme.has_stylebox("scroll", "ScrollBar"):
		theme.set_stylebox("scroll", "ScrollBar", StyleBox.new())

	# Set the scroll width (scroll_size constant)
	theme.set_constant("scroll_size", "ScrollBar", 20)  # Example: 20 pixels width

	# Assign the theme to the ScrollContainer
	scroll_container.theme = theme

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
