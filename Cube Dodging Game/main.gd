extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_start_button_button_down():
	Game.gamemode = "singleplayer"
	get_tree().change_scene_to_file("res://game_scene.tscn")


func _on_quit_button_button_down():
	get_tree().quit()


func _on_multiplayer_button_button_down():
	Game.gamemode = "multiplayer"
	get_tree().change_scene_to_file("res://Multiplayer/multiplayer_game_scene.tscn")
