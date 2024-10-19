extends Sprite2D
class_name Draggable

@export var drag_delay: float = .2

var is_dragging: bool = false
var mouse_offset: Vector2

func _physics_process(delta):
	if is_dragging:
		position = position.lerp(get_global_mouse_position() - mouse_offset, drag_delay )
		
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if get_rect().has_point(to_local(event.position)):
				print('clicked on sprite')
				is_dragging = true
				mouse_offset = get_global_mouse_position()-global_position
		else:
			is_dragging = false
