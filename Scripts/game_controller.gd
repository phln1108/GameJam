extends Node


@onready var tent: TextureRect = $CanvasLayer/Tent
@onready var notes: TextureRect = $CanvasLayer/Notes
@onready var recipes: TextureRect = $CanvasLayer/Recipes


func _on_back_from_notes() -> void:
	tent.visible = true
	notes.visible = false


func _on_back_from_recipes() -> void:
	tent.visible = true
	recipes.visible = false


func _on_go_to_recipes() -> void:
	tent.visible = false
	recipes.visible = true


func _on_go_to_notes() -> void:
	tent.visible = false
	notes.visible = true
