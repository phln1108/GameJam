extends Label

@export var dialogue_text: String
var current_char: int = 0
var is_typing: bool = false

# Tempo entre cada caractere
@onready var timer: Timer = $Timer

func _ready() -> void:
	show_dialogue()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("skip_dialogue"):
		text = dialogue_text
		is_typing = false
	

func show_dialogue():
	text = ""
	current_char = 0
	is_typing = true
	
	_start_typing()

func _start_typing():
	if is_typing:
		if current_char == dialogue_text.length():
			is_typing = false
		else:
			text += dialogue_text[current_char]
			current_char += 1
			timer.start()
		


func _on_timer_timeout() -> void:
	if is_typing:
		_start_typing()
