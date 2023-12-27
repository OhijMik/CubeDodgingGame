extends CharacterBody2D


var speed = 150.0
var speed_up = false
var blink = false
var original_pos


func _enter_tree():
	set_multiplayer_authority(name.to_int())
	if Game.gamemode == "singleplayer":
		position = Vector2(576, 320)
	elif name == "1":
		position = Vector2(256, 320)
	else:
		position = Vector2(800, 320)


func _physics_process(_delta):
	if is_multiplayer_authority() and Game.gamemode == "multiplayer":
		movement()
	elif Game.gamemode == "singleplayer":
		movement()
	if blink and position.distance_to(original_pos) >= 100:
		blink = false
		speed = 150
	move_and_slide()


func movement():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	if Input.is_action_just_pressed("BLINK") and Game.blink_amount > 0:
		blink = true
		original_pos = position
		speed = 1000
		Game.blink_amount -= 1
	if Input.is_action_just_pressed("SPEED_UP") and Game.speed_up_amount > 0:
		speed_up = true
		speed = speed * 2
		Game.speed_up_amount -= 1
		get_node("Timer").start(5)
		

func _on_timer_timeout():
	speed_up = false
	speed = speed / 2
