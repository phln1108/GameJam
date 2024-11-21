extends Sprite2D

var current_page: int = 0

@export var pages: Array[Texture]

@export var back: TextureButton
@export var forward: TextureButton

func _ready() -> void:
	pages.append("res://icon.svg")
	texture = pages[0]
	forward.visible = false

func append_page(page: String) -> void:
	pages.append(page)

func pass_page():
	current_page += 1
	if (current_page == len(pages)):
		current_page = 0
	#forward.visible = not len(pages) -1 == current_page
	#back.visible = true
	
	texture = pages[current_page]

func back_page():
	current_page -= 1
	if (current_page < 0):
		current_page = len(pages) - 1
	#back.visible = not 0 == current_page
	#forward.visible = true
	
	texture = pages[current_page]

func close_book():
	current_page = 0
	texture = pages[0]
