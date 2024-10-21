extends Control

@export var dialogue : Control
@export var skip_button: TextureButton

var npc_sprite: Sprite2D = null
var walk_npc: bool = false
var speed  := 200

var max_rotation = deg_to_rad(3)
var step_rotation= deg_to_rad(.5)

var target :Control 

#se é a fala final
var ending = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HistoryController.new_npc.connect(_on_new_npc)
	HistoryController.get_random_npc()
	HistoryController.requirements_completed.connect(_on_complete_requirements)
	
	dialogue.finished_dialogue.connect(_on_finished_dialogue)
	
	skip_button.pressed.connect(_on_skip)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if walk_npc:
		npc_sprite.rotation += step_rotation
		if absf(npc_sprite.rotation) > max_rotation:
			step_rotation *= -1
		
		var distance: Vector2 = (target.position - npc_sprite.position).normalized()
		npc_sprite.position += distance * speed * delta
		
		if distance.x < .1:
			walk_npc = false
			if target == $NpcStopPoint:
				skip_button.visible = true
				
				HistoryController.get_items_from_npc.emit()
				
				npc_sprite.rotation = 0
				dialogue.dialogues = HistoryController.current_npc.start_dialogue
				dialogue.current_dialogue = 0
				dialogue.dialogue_text = dialogue.dialogues[0]

				print(HistoryController.current_npc.start_dialogue)
				dialogue.show_dialogue()
			else:
				npc_sprite.queue_free()
				npc_sprite = null
				get_tree().create_timer(2).timeout.connect(HistoryController.get_random_npc)
				

func _on_new_npc() -> void:
	skip_button.visible = false
	target = $NpcStopPoint
	var new_npc = HistoryController.current_npc
	npc_sprite = Sprite2D.new()
	npc_sprite.texture = ResourceLoader.load(new_npc.image)
	npc_sprite.scale = Vector2(10,10)
	npc_sprite.position = $NpcSpawn.position
	add_child(npc_sprite)
	walk_npc = true

func _on_skip() -> void:
	skip_button.visible = false
	HistoryController.requirements_refused.emit()
	skip_button.release_focus()
	dialogue.dialogues = HistoryController.current_npc.no
	dialogue.current_dialogue = 0
	dialogue.dialogue_text = dialogue.dialogues[0]

	print(HistoryController.current_npc.no)
	dialogue.show_dialogue()
	ending = true
	
	
func _on_complete_requirements() -> void:
	skip_button.visible = false
	
	dialogue.dialogues = HistoryController.current_npc.yes
	dialogue.current_dialogue = 0
	dialogue.dialogue_text = dialogue.dialogues[0]

	print(HistoryController.current_npc.yes)
	dialogue.show_dialogue()
	ending = true

func _on_finished_dialogue():
	if ending:
		target = $NpcDespawnPoint
		dialogue.hide_dialogue()
		walk_npc = true
		ending = false
