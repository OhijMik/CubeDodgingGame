extends Node2D


var triangle = preload("res://Enemy/enemy_triangle.tscn")


func _on_timer_timeout():
	var triangleTemp = triangle.instantiate()
	var rng = RandomNumberGenerator.new()
	var randInt = rng.randi_range(0, 3)
	if randInt == 0:
		triangleTemp.position = Vector2(rng.randi_range(0, 570), 0)
	elif randInt == 1:
		triangleTemp.position = Vector2(rng.randi_range(0, 570), 650)
	elif randInt == 2:
		triangleTemp.position = Vector2(0, rng.randi_range(0, 650))
	else:
		triangleTemp.position = Vector2(570, rng.randi_range(0, 650))
	add_child(triangleTemp)
