extends Control

@export var dialogue : Control
@export var skip_button: Button

var npc_sprite: Sprite2D = null
var walk_npc: bool = false
var speed  := 200

var max_rotation = deg_to_rad(3)
var step_rotation= deg_to_rad(.5)

var target :Control 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HistoryController.new_npc.connect(_on_new_npc)
	HistoryController.get_random_npc()
	
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
	target = $NpcStopPoint
	var new_npc = HistoryController.current_npc
	npc_sprite = Sprite2D.new()
	npc_sprite.texture = load(new_npc.image)
	npc_sprite.scale = Vector2(10,10)
	npc_sprite.position = $NpcSpawn.position
	add_child(npc_sprite)
	walk_npc = true
	
func _on_skip() -> void:
	target = $NpcDespawnPoint
	dialogue.hide_dialogue()
	walk_npc = true
	skip_button.release_focus()
