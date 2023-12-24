extends Node2D

var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene


func _on_host_button_pressed():
	peer.create_server(135)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	_add_player()
	_change_visibility("HostButton")
	_change_visibility("JoinButton")
	_change_visibility("StartButton")
	

func _add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child", player)
	

func _on_join_button_pressed():
	peer.create_client("localhost", 135)
	multiplayer.multiplayer_peer = peer
	_change_visibility("HostButton")
	_change_visibility("JoinButton")
	_change_visibility("BackButton")


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
	

func _on_start_button_pressed():
	_change_visibility("StartButton")
	_change_visibility("BackButton")
	get_node("EnemySpawn/Timer").start()


func _change_visibility(node_name):
	if get_node(node_name).visible == true:
		get_node(node_name).visible = false
	else:
		get_node(node_name).visible = true


