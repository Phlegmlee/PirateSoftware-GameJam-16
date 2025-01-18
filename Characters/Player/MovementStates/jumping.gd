extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	#player.anim_state.travel("Jump_Full_Long")
	print("Enter Jumping State")
	

func physics_update(delta: float) -> void:
	handle_jumping()
	player.move_and_slide()

	if player.velocity.y >= 0:
		finished.emit(FALLING)

func handle_jumping():
	if player.jumping_enabled:
		if player.continuous_jumping: # Hold down the jump button
			if Input.is_action_pressed("jump") and player.is_on_floor():
				player.velocity.y += player.jump_velocity # Adding instead of setting so jumping on slopes works properly
				print("JUMPING")
		else:
			if Input.is_action_just_pressed("jump") and player.is_on_floor():
				player.velocity.y += player.jump_velocity
