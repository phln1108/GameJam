extends Control

signal item_removed

var draggable = preload("res://Scenes/draggable.tscn")
@onready var sprite = $Sprite2D

@export var item: Item
@onready var quantity: int:
	set(value):
		quantity = value
		$Label.text = str(value)
		if value == 0:
			sprite.modulate = Color("#3d3d3d8d")
		else:
			$Sprite2D.modulate = Color("#ffffff")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = str(quantity)
	sprite.texture = load(item.image)
	# Access the ScrollContainer's theme

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and sprite.get_rect().has_point(sprite.to_local(event.position)) and quantity > 0:
			var item_drag = draggable.instantiate()
			item_drag.item = item
			item_drag.is_dragging = true
			item_drag.mouse_offset = get_global_mouse_position() - global_position
			item_drag.global_position = global_position
			item_drag.returned.connect(on_item_returned)
			get_tree().root.add_child(item_drag)
			quantity-=1
			accept_event()
			
func on_item_returned() -> void:
	quantity+=1
