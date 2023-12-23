extends Node2D


func _on_start_button_button_down():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_quit_button_button_down():
	get_tree().quit()
