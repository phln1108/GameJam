extends Sprite2D

# Essa implementação serve pro livro de receitas e pras notas.
# É basciamente um passador de images.
# Tá meio cru, mas o foco agora é fazer funcionar.
#var pages: Array[String] = []
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
	forward.visible = not len(pages) -1 == current_page
	
	texture = pages[current_page]
	
func back_page():
	current_page -= 1
	back.visible = not 0 == current_page
	
	texture = pages[current_page]

func close_book():
	current_page = 0
	texture = pages[0]
