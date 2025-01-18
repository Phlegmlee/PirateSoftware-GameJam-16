extends PlayerState

## INPUT MAP STRINGS
var moveUp : String = "move_up"
var moveDown : String = "move_down"
var moveLeft : String = "move_left"
var moveRight : String = "move_right"

func enter(previous_state_path: String, data := {}) -> void:
	player.anim_state.travel("Walk")
	print("Enter Running State")

func physics_update(delta: float) -> void:
	## Player Movement Input Capture
	var input_dir = Vector2.ZERO
	if !player.immobile: # Immobility works by interrupting user input, so other forces can still be applied to the player
		input_dir = Input.get_vector(moveLeft, moveRight, moveUp, moveDown)
		player.anim_tree.set("parameters/Walk/blend_position", input_dir)
	handle_movement(delta, input_dir)

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif !input_dir:
		finished.emit(IDLE)


func handle_movement(delta, input_dir):
	var direction = input_dir
	direction = Vector3(direction.x, 0, direction.y)
	player.move_and_slide()
	
	if player.is_on_floor():
		if player.motion_smoothing:
			player.velocity.x = lerp(player.velocity.x, direction.x * player.speed, player.acceleration * delta)
			player.velocity.z = lerp(player.velocity.z, direction.z * player.speed, player.acceleration * delta)
		else:
			player.velocity.x = direction.x * player.speed
			player.velocity.z = direction.z * player.speed
