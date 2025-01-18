class_name PlayerState extends State

const IDLE = "Idle"
const ROLLING = "Rolling"
const WALKING = "Walking"
const FALLING = "Falling"
const JUMPING = "Jumping"


var player: PlayerEntity


func _ready() -> void:
	await owner.ready
	player = owner as PlayerEntity
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
