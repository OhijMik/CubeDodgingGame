extends CharacterBody2D


const speed = 150.0


func _enter_tree():
	set_multiplayer_authority(name.to_int())
	if name == "1":
		position = Vector2(256, 320)
	else:
		position = Vector2(800, 320)


func _physics_process(delta):
	if is_multiplayer_authority() and Game.gamemode == "multiplayer":
		if Input.is_action_pressed("ui_left"):
			position.x -= speed * delta
		if Input.is_action_pressed("ui_right"):
			position.x += speed * delta
		if Input.is_action_pressed("ui_up"):
			position.y -= speed * delta
		if Input.is_action_pressed("ui_down"):
			position.y += speed * delta
	elif Game.gamemode == "singleplayer":
		if Input.is_action_pressed("ui_left"):
			position.x -= speed * delta
		if Input.is_action_pressed("ui_right"):
			position.x += speed * delta
		if Input.is_action_pressed("ui_up"):
			position.y -= speed * delta
		if Input.is_action_pressed("ui_down"):
			position.y += speed * delta
	move_and_slide()

