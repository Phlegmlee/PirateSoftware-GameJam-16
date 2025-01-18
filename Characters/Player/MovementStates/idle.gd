extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity = Vector3.ZERO
	player.anim_state.travel("Ball_Idle")
	print("Enter Idle State")

func physics_update(_delta: float) -> void:
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(WALKING)
	elif Input.get_vector("move_left", "move_right", "move_up", "move_down"):
		finished.emit(WALKING)
