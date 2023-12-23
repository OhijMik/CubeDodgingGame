extends Node2D

var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene


func _on_host_button_pressed():
	peer.create_server(135)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	get_tree().change_scene_to_file("res://game_scene.tscn")
	_add_player(1)
	

func _add_player(id):
	var player = player_scene.instantiate()
	player.name = str(id)
	player.position = Vector2(800, 320)
	add_child(player)


func _on_join_button_pressed():
	peer.create_client("localhost", 135)
	multiplayer.multiplayer_peer = peer
	get_tree().change_scene_to_file("res://game_scene.tscn")


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
