extends Control



var scenarios = []

@onready var timer: Timer = $characterTimer

signal finished_dialogue

@export var dialogues: Array
var dialogue_text: String

var current_char: int = 0
var current_dialogue: int = 0

var is_typing: bool = false
var started: = false

@export var step = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	print(step)
	step += 10
	$ColorRect.color += Color(0,0,0,0.1)
	if step == 100:
		$Timer.stop()
	else:
		$Timer.start()


func _input(event: InputEvent) -> void:
	if not started:
		return
	
	if event.is_action_pressed("skip_dialogue"):
		if is_typing:
			$Label.text = dialogue_text
			is_typing = false
		else:
			if current_dialogue < len(dialogues) - 1:
				current_dialogue += 1
				dialogue_text =  dialogues[current_dialogue]
				show_dialogue()
			else:
				finished_dialogue.emit()
				started = false
				
func show_dialogue():
	started = true
	visible = true
	$Label.text = ""
	current_char = 0
	is_typing = true
	_type()

func _type():
	if is_typing:
		if current_char == dialogue_text.length():
			is_typing = false
		else:
			$Label.text += dialogue_text[current_char]
			current_char += 1
			timer.start()
	


func _on_character_timer_timeout() -> void:
	if is_typing:
		_type()
