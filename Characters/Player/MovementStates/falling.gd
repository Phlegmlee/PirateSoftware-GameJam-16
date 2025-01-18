extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	#player.anim_state.travel("Jump_Idle")
	print("Enter Falling State")

func physics_update(delta: float) -> void:
	var input_dir := Input.get_vector("move_left","move_right","move_up","move_down")
	var direction = input_dir
	direction = Vector3(direction.x, 0, direction.y)
	player.move_and_slide()
	
	if player.in_air_momentum:
		player.velocity.x = direction.x * player.speed
		player.velocity.z = direction.z * player.speed
	
	if player.is_on_floor():
		#player.anim_state.travel("Jump_Land")
		if !input_dir:
			finished.emit(IDLE)
		else:
			finished.emit(WALKING)
