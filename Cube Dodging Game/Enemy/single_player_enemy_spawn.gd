extends Node2D


var triangle = preload("res://Enemy/enemy_triangle.tscn")
var enemy_spawn = {'amount': [5,7,10,15,15,20,25,30,35,40], 
					'time': [3,2,2,2,2,1,1,1,1,0.75],
					'speed': [180,200,250,300,300,350,400,450,500,600]}
var enemy_amount = 0
var stop_spawn = false
var round_points = 0

var timer

func _on_timer_ready():
	timer = get_node("SpawnTimer")


func _process(_delta):
	if Game.game_round <= 10:
		# stops the spawn after the set amount of enemies
		if enemy_amount >= enemy_spawn['amount'][Game.game_round - 1]:
			stop_spawn = true
		# starts the spawn after the round ends and resets the variables
		if stop_spawn and enemy_spawn['amount'][Game.game_round - 1] * 100 == Game.round_points:
			stop_spawn = false
			enemy_amount = 0
			Game.round_points = 0
			Game.game_round += 1
			timer.set_wait_time(enemy_spawn['time'][Game.game_round - 1])
			Game.enemy_triangle_speed = enemy_spawn['speed'][Game.game_round - 1]
	else:
		# stops the spawn after the set amount of enemies
		if enemy_amount >= enemy_spawn['amount'][9]:
			stop_spawn = true
		# starts the spawn after the round ends and resets the variables
		if stop_spawn and enemy_spawn['amount'][9] * 100 == Game.round_points:
			stop_spawn = false
			enemy_spawn['amount'][9] += 10
			enemy_amount = 0
			Game.round_points = 0
			Game.game_round += 1
			Game.enemy_triangle_speed += 50
			timer.set_wait_time(0.5)


func _on_timer_timeout():
	if !stop_spawn:
		var triangleTemp = triangle.instantiate()
		var rng = RandomNumberGenerator.new()
		var randInt = rng.randi_range(0, 3)
		if randInt == 0:
			triangleTemp.position = Vector2(rng.randi_range(0, 1150), 0)
		elif randInt == 1:
			triangleTemp.position = Vector2(rng.randi_range(0, 1150), 650)
		elif randInt == 2:
			triangleTemp.position = Vector2(0, rng.randi_range(0, 650))
		else:
			triangleTemp.position = Vector2(1150, rng.randi_range(0, 650))
		enemy_amount += 1
		add_child(triangleTemp)
