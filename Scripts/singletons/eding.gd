extends Control

var scenarios = [
	"A fumaça das aldeias incendiadas ainda pairava no horizonte, mas havia esperança. Com suas mãos habilidosas, você entregou aos povos originários mais do que simples ferramentas – você deu a eles a chance de resistir. Seu nome será sussurrado entre as árvores, uma lenda viva que lutou ao lado daqueles que defendiam sua terra. Suas ações ajudaram a manter viva a cultura, a coragem e a força de um povo. Embora os invasores continuem a avançar, sua contribuição deu à resistência fôlego e fé. Para os povos originários, você é mais que um aliado – é um guardião da terra.",
	"Sob o estandarte da Coroa Portuguesa, suas habilidades se tornaram uma peça chave na consolidação da conquista. O território, antes hostil e desconhecido, agora floresce sob o domínio da Coroa, e sua mão esteve presente em cada passo dessa expansão. Ao lado dos colonizadores, você forjou armas, munição e estruturas que fortaleceram o império. Sua lealdade foi reconhecida e recompensada com terras e títulos, e seu nome será lembrado nas crônicas da conquista do Novo Mundo. Para os portugueses, você é mais que um artesão – é um construtor do futuro que eles tanto sonharam.",
]

@onready var timer: Timer = $characterTimer

signal finished_dialogue

@export var dialogues: Array = []
var dialogue_text: String

var current_char: int = 0
var current_dialogue: int = 0

var is_typing: bool = false
var started: = false

@export var step = 0

func finish() -> void:
	$Label.text = ""
	dialogues.append(scenarios[1 if HistoryController.wheight == -5 else 0])
	dialogue_text = scenarios[1 if HistoryController.wheight == -5 else 0]
	$ColorRect.visible = true
	$Timer.start()

func _on_timer_timeout() -> void:
	print(step)
	step += 10
	$ColorRect.color += Color(0,0,0,0.1)
	if step == 100:
		$Label.visible = true
		started = true
		show_dialogue()
		$Timer.stop()
	else:
		$Timer.start()


func _ready() -> void:
	#finish()
	pass

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
				$Button.visible = true
				
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


func _on_button_pressed() -> void:
	$Node2D.get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
