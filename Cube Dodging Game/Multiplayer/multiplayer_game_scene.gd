#extends Node2D
#
#var peer = ENetMultiplayerPeer.new()
#@export var player_scene: PackedScene
#@export var enemy_scene: PackedScene
#var file = 'res://PlayerInfo.txt'
#
#signal player_connected(peer_id, player_info)
#signal player_disconnected(peer_id)
#signal server_disconnected
#
#const PORT = 135
#const DEFAULT_SERVER_IP = "127.0.0.1" # IPv4 localhost
#const MAX_CONNECTIONS = 3
#
#var players = {}
#
#var player_info = {"name": "Name"}
#
#var players_loaded = 0
#
#func _ready():
	#multiplayer.peer_connected.connect(_on_player_connected)
	#multiplayer.peer_disconnected.connect(_on_player_disconnected)
	#multiplayer.connected_to_server.connect(_on_connected_ok)
	#multiplayer.connection_failed.connect(_on_connected_fail)
	#multiplayer.server_disconnected.connect(_on_server_disconnected)
#
#
#func _on_host_button_pressed():
	#var peer = ENetMultiplayerPeer.new()
	#var error = peer.create_server(PORT, MAX_CONNECTIONS)
	#if error:
		#return error
	#multiplayer.multiplayer_peer = peer
	#multiplayer.peer_connected.connect(_add_player)
	#_add_player()
#
	#players[1] = player_info
	#player_connected.emit(1, player_info)
	#_hide("Buttons/HostButton")
	#_hide("Buttons/JoinButton")
	#_show("Buttons/StartButton")
	#
#
#func _add_player(id = 1):
	#var player = player_scene.instantiate()
	#player.name = str(id)
	#call_deferred("add_child", player)
	#
#
#func _on_join_button_pressed(address = ""):
	#if address.is_empty():
		#address = DEFAULT_SERVER_IP
	#var peer = ENetMultiplayerPeer.new()
	#var error = peer.create_client(address, PORT)
	#if error:
		#return error
	#multiplayer.multiplayer_peer = peer
	#_hide("Buttons/HostButton")
	#_hide("Buttons/JoinButton")
	#_hide("Buttons/BackButton")
	#
	#var f = FileAccess.open(file, FileAccess.WRITE)
	#f.store_string(str(multiplayer.multiplayer_peer.get_unique_id()))
	#f.close()
	#
	#
#func remove_multiplayer_peer():
	#multiplayer.multiplayer_peer = null
	#
#@rpc("call_local", "reliable")
#func load_game(game_scene_path):
	#get_tree().change_scene_to_file(game_scene_path)
#
## Every peer will call this when they have loaded the game scene.
#@rpc("any_peer", "call_local", "reliable")
#func player_loaded():
	#if multiplayer.is_server():
		#players_loaded += 1
#
#
## When a peer connects, send them my player info.
## This allows transfer of all desired data for each player, not only the unique ID.
#func _on_player_connected(id):
	#_register_player.rpc_id(id, player_info)
#
#
#@rpc("any_peer", "reliable")
#func _register_player(new_player_info):
	#var new_player_id = multiplayer.get_remote_sender_id()
	#players[new_player_id] = new_player_info
	#player_connected.emit(new_player_id, new_player_info)
#
#
#func _on_player_disconnected(id):
	#players.erase(id)
	#player_disconnected.emit(id)
#
#
#func _on_connected_ok():
	#var peer_id = multiplayer.get_unique_id()
	#players[peer_id] = player_info
	#player_connected.emit(peer_id, player_info)
#
#
#func _on_connected_fail():
	#multiplayer.multiplayer_peer = null
#
#
#func _on_server_disconnected():
	#multiplayer.multiplayer_peer = null
	#players.clear()
	#server_disconnected.emit()
	#
#
#func _on_back_button_pressed():
	#get_tree().change_scene_to_file("res://main.tscn")
	#
#
#func _on_start_button_pressed():
	#get_node("EnemySpawn/Timer").start()
	#_hide("Buttons/StartButton")
	#_hide("Buttons/BackButton")
	#
#
#func _show(node_name):
	#get_node(node_name).visible = true
		#
#func _hide(node_name):
	#get_node(node_name).visible = false
#
#
#func _on_timer_timeout():
	#var peer = ENetMultiplayerPeer.new()
	#var error = peer.create_client(DEFAULT_SERVER_IP, PORT)
	#if error:
		#return error
	#multiplayer.peer_connected.connect(_add_enemy)
	#multiplayer.multiplayer_peer = peer
	#_add_enemy()
	#_add_enemy(3)
#
#
#func _add_enemy(id = 2):
	#var enemy = enemy_scene.instantiate()
	#enemy.name = str(id)
	#call_deferred("add_child", enemy)
#

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
	#var peer = ENetMultiplayerPeer.new()
	#peer.create_client("localhost", 135)
	#multiplayer.multiplayer_peer = peer
	#multiplayer.peer_connected.connect(_add_enemy)
	#_add_enemy()
	get_node("EnemySpawn/Timer").start()
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
	_add_enemy()
	_add_enemy(3)
