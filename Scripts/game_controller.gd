extends Node


@export  var tent: Control
@export var crafting: Control
@export var notes: Control

func _ready() -> void:
	change_visibility(tent,true)
	change_visibility(notes,false)
	change_visibility(crafting,false)

func change_visibility(node: CanvasItem, visible: bool) -> void:
	node.visible = visible
	for n in node.get_children():
		n.visible = visible

func _on_back_from_notes() -> void:
	print("aa")
	change_visibility(tent,true)
	change_visibility(notes,false)

func _on_back_from_crafting() -> void:
	print("aa")
	change_visibility(tent,true)
	change_visibility(crafting,false)

func _on_go_to_crafting() -> void:
	print("aa")
	change_visibility(tent,false)
	change_visibility(crafting,true)

func _on_go_to_notes() -> void:
	print("aa")
	change_visibility(tent,false)
	change_visibility(notes,true)
