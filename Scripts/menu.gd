extends Control

func _on_start_pressed() -> void:
	$Node2D.get_tree().quit()

func _on_quit_pressed() -> void:
	$Node2D.get_tree().change_scene_to_file("res://Scenes/game.tscn")
