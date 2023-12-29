extends Node2D

var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene
@export var enemy_scene: PackedScene
var player_id = "res://PlayerInfo.txt"
var max_players = 10
var triangle = preload("res://Enemy/enemy_triangle.tscn")

var address = "localhost"
var port = 135


func _on_host_button_pressed():
	peer.create_server(port, max_players)
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
	peer.create_client(address, port)
	multiplayer.multiplayer_peer = peer
	_hide("Buttons/HostButton")
	_hide("Buttons/JoinButton")
	_hide("Buttons/BackButton")
	
	var f = FileAccess.open(player_id, FileAccess.WRITE)
	f.store_string(str(multiplayer.multiplayer_peer.get_unique_id()))
	f.close()


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
	

func _on_start_button_pressed():
	multiplayer.peer_connected.connect(_add_enemy)
	get_node("EnemySpawn/Timer").start()
	_hide("Buttons/StartButton")
	_hide("Buttons/BackButton")


func _add_enemy(id = 2):
	var enemy = enemy_scene.instantiate()
	var rng = RandomNumberGenerator.new()
	var randInt = rng.randi_range(0, 3)
	if randInt == 0:
		enemy.position = Vector2(rng.randi_range(0, 1150), 0)
	elif randInt == 1:
		enemy.position = Vector2(rng.randi_range(0, 1150), 650)
	elif randInt == 2:
		enemy.position = Vector2(0, rng.randi_range(0, 650))
	else:
		enemy.position = Vector2(1150, rng.randi_range(0, 650))
	enemy.name = str(id)
	add_child(enemy, true)
	

func _show(node_name):
	get_node(node_name).visible = true
		
func _hide(node_name):
	get_node(node_name).visible = false


func _on_timer_timeout():
	multiplayer.multiplayer_peer = peer
	_add_enemy()
