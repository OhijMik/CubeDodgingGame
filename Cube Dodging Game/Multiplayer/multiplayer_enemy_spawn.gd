extends Node2D


var triangle = preload("res://Enemy/enemy_triangle.tscn")


func _on_timer_timeout():
	var triangleTemp1 = triangle.instantiate()
	var rng = RandomNumberGenerator.new()
	var randInt = rng.randi_range(0, 3)
	if randInt == 0:
		triangleTemp1.position = Vector2(rng.randi_range(0, 570), 0)
	elif randInt == 1:
		triangleTemp1.position = Vector2(rng.randi_range(0, 570), 650)
	elif randInt == 2:
		triangleTemp1.position = Vector2(0, rng.randi_range(0, 650))
	else:
		triangleTemp1.position = Vector2(570, rng.randi_range(0, 650))
	
	var triangleTemp2 = triangle.instantiate()
	randInt = rng.randi_range(0, 3)
	if randInt == 0:
		triangleTemp2.position = Vector2(rng.randi_range(583, 1180), 0)
	elif randInt == 1:
		triangleTemp2.position = Vector2(rng.randi_range(583, 1180), 650)
	elif randInt == 2:
		triangleTemp2.position = Vector2(583, rng.randi_range(0, 650))
	else:
		triangleTemp2.position = Vector2(1180, rng.randi_range(0, 650))
	#add_child(triangleTemp1)
	#add_child(triangleTemp2)
	
	var peer = ENetMultiplayerPeer.new()
	multiplayer.multiplayer_peer = peer
	
