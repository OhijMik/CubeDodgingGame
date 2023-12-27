extends Node2D

var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene
@export var enemy_scene: PackedScene
var file = 'res://PlayerInfo.txt'


func _on_host_button_pressed():
	print(multiplayer.multiplayer_peer)
	peer.create_server(135)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	_add_player()
	_hide("Buttons/HostButton")
	_hide("Buttons/JoinButton")
	_show("Buttons/StartButton")
	

func _add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child", player)
	

func _on_join_button_pressed():
	peer.create_client("localhost", 135)
	multiplayer.multiplayer_peer = peer
	_hide("Buttons/HostButton")
	_hide("Buttons/JoinButton")
	_hide("Buttons/BackButton")
	
	var f = FileAccess.open(file, FileAccess.WRITE)
	f.store_string(str(multiplayer.multiplayer_peer.get_unique_id()))
	f.close()


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
	

func _on_start_button_pressed():
	#peer.create_client("localhost", 135)
	print(multiplayer.multiplayer_peer)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_enemy)
	_add_enemy()
	#get_node("EnemySpawn/Timer").start()
	_hide("Buttons/StartButton")
	_hide("Buttons/BackButton")


func _add_enemy(id = 2):
	var enemy = enemy_scene.instantiate()
	enemy.name = str(id)
	call_deferred("add_child", enemy)
	

func _show(node_name):
	get_node(node_name).visible = true
		
func _hide(node_name):
	get_node(node_name).visible = false


func _on_timer_timeout():
	print(multiplayer.get_peers())
	_add_enemy()
	# _add_enemy(3)
