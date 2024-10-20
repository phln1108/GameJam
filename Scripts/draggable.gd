extends Control
class_name Draggable

@export var drag_delay: float = 0.2
@export var item: Item

var is_dragging: bool = false

var mouse_offset: Vector2

# Reference to the Sprite2D child
var sprite: Sprite2D

var previous_position = Vector2.ZERO
var rotation_amount = 15.0

func _ready() -> void:
	sprite = $Sprite2D
	sprite.texture = load(item.image)

func _physics_process(delta) -> void:
	if is_dragging:
		# Move the Control node (which moves the sprite as well)
		global_position = global_position.lerp(get_global_mouse_position() - mouse_offset, drag_delay)
		
		var direction = global_position.x - previous_position.x
		
		if direction > 2:
			rotation_degrees = lerp(rotation_degrees, rotation_amount, 0.3)
		elif direction < -2:
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
				# Detect click on the sprite and start dragging
				print('clicked on topmost sprite')
				is_dragging = true
				mouse_offset = get_global_mouse_position() - global_position
				accept_event()  # Stop propagation to other nodes
		else:
			is_dragging = false
