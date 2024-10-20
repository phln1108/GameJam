extends Control
class_name Draggable

signal stop_dragging
signal returned

@export var drag_delay: float = 0.2
@export var item: Item

var is_dragging: bool = false:
	set(value):
		is_dragging = value
		if not is_dragging:
			stop_dragging.emit(self)
			
var mouse_offset: Vector2

var sprite: Sprite2D

var previous_position = Vector2.ZERO
var rotation_amount = 15.0

func _ready() -> void:
	sprite = $Sprite2D
	sprite.texture = load(item.image)

func _physics_process(_delta) -> void:
	if is_dragging:
		global_position = global_position.lerp(get_global_mouse_position() - mouse_offset, drag_delay)
		
		var direction = global_position.x - previous_position.x
		
		if direction > 20:
			rotation_degrees = lerp(rotation_degrees, rotation_amount, 0.3)
		elif direction < -20:
			rotation_degrees = lerp(rotation_degrees, -rotation_amount, 0.3)
		else:
			rotation_degrees = lerp(rotation_degrees, 0.0, 0.3)
		
		previous_position = global_position
	else:
		rotation_degrees = lerp(rotation_degrees, 0.0, 0.3)

func _input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if sprite.get_rect().has_point(sprite.to_local(event.position)):
				is_dragging = true
				mouse_offset = get_global_mouse_position() - global_position
				accept_event()
		else:
			is_dragging = false
