extends Control
class_name ItemContainer

signal item_removed

var draggable = preload("res://Scenes/draggable.tscn")
@onready var sprite = $Sprite2D

@export var item: Item
@export var parent: Node = null

@onready var quantity: int:
	set(value):
		quantity = value
		$Label.text = str(value)
		if value == 0:
			sprite.modulate = Color("#3d3d3d8d")
		else:
			$Sprite2D.modulate = Color("#ffffff")

func _ready() -> void:
	$Label.text = str(quantity)
	sprite.texture = load(item.image)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and sprite.get_rect().has_point(sprite.to_local(event.position)) and quantity > 0:
			var item_drag = draggable.instantiate()
			item_drag.item = item
			item_drag.is_dragging = true
			
			#algum bug ta fazendo com que o item spawne muito em baixo e pegue o offset errado
			#acho que tem haver com o scale aplicado
			item_drag.mouse_offset = get_global_mouse_position() - global_position - Vector2(20,0)
			item_drag.global_position = global_position - Vector2(-20,0)
			item_drag.returned.connect(on_item_returned)
			parent.add_child(item_drag)
			quantity-=1
			accept_event()

func on_item_returned() -> void:
	quantity+=1
	
