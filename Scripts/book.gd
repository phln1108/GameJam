extends Sprite2D

# Essa implementação serve pro livro de receitas e pras notas.
# É basciamente um passador de images.
# Tá meio cru, mas o foco agora é fazer funcionar.
var pages: Array[String] = []
var current_page: int = 0

func _ready() -> void:
	pages.append("res://icon.svg")
	texture = load(pages[0])

func append_page(page: String) -> void:
	pages.append(page)

func pass_page():
	current_page += 1
	texture = load(pages[current_page])
	
func close_book():
	current_page = 0
	texture = load(pages[0])

	
