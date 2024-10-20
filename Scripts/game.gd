extends Node


@export  var tent: Control
@export var crafting: Control
@export var notes: Control

func _ready() -> void:
	tent.visible = true
	change_visibility(notes,false)
	change_visibility(crafting,false)

func change_visibility(node: CanvasItem, visible: bool) -> void:
	node.visible = visible
	if node is Control:
		node.mouse_filter = Control.MOUSE_FILTER_STOP if visible else Control.MOUSE_FILTER_IGNORE
	for n in node.get_children():
		n.visible = visible
		if n is Control:
			n.mouse_filter = Control.MOUSE_FILTER_STOP if visible else Control.MOUSE_FILTER_IGNORE

func _on_back_from_notes() -> void:
	tent.visible = true
	change_visibility(notes,false)
	change_visibility(crafting,false)

func _on_back_from_crafting() -> void:
	print("aa")
	tent.visible = true
	change_visibility(crafting,false)

func _on_go_to_crafting() -> void:
	tent.visible = false
	change_visibility(crafting,true)

func _on_go_to_notes() -> void:
	tent.visible = false
	change_visibility(notes,true)
