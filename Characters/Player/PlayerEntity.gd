class_name PlayerEntity
extends CharacterBody3D

@export_category("Player Character")
@export var base_speed : float = 2.0
@export var run_speed : float = 5.0
@export var sprint_speed : float = 7.0
@export var acceleration : float = 10.0
@export var mouse_sensitivity : float = 0.1
@export var jump_velocity : float = 5.5
@export var immobile : bool = false

@export_category("Nodes")
@export var player : CharacterBody3D
@export var camera : Camera3D
@export var camera_pivot : Node3D
@export var model : Node3D
@export var anim_tree : AnimationTree
@onready var anim_state = anim_tree.get("parameters/playback")

@export_category("Controls")
@export_group("Interaction")
@export var interaction : String = "interaction"
@export_group("Character Abilities")
@export var ability_slot_one : String = "character_ability_slot_one"
@export var ability_slot_two : String = "character_ability_slot_two"
@export_group("Gunplay")
@export var primary_shot : String = "primary_shoot"
@export var secondary_shoot : String = "secondary_shoot"
@export var reload : String = "reload"

@export_category("Settings")
@export_group("Feature Settings")
@export var jumping_enabled : bool = true
@export var in_air_momentum : bool = true
@export var motion_smoothing : bool = false
@export var sprint_enabled : bool = false
@export_enum("Hold to Sprint", "Toggle Sprint") var sprint_mode : int = 0
@export var continuous_jumping : bool = true
@export var jump_animation : bool = true
@export var pausing_enabled : bool = true
@export var gravity_enabled : bool = true
#
## -- Member variables --
var speed := run_speed

## Camera Raycast Variables
var ray_origin = Vector3(0.0, 0.0, 0.0)
var ray_target = Vector3(0.0, 0.0, 0.0)

# Get the gravity from the project settings to be synced with CharacterBody nodes
var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity") # Don't set this as a const, see the gravity section in _physics_process

func _physics_process(delta):
	## Gravity
	if not is_on_floor() and gravity and gravity_enabled:
		velocity.y -= gravity * delta
	
	## Player Camera Raycast to Mouse Pos
	var space_state = get_world_3d().direct_space_state
	var mouse_position = get_viewport().get_mouse_position()
	ray_origin = camera.project_ray_origin(mouse_position)
	ray_target = ray_origin + camera.project_ray_normal(mouse_position) * 2000
	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_target)
	var intersection = space_state.intersect_ray(query)
	
	## Look at mouse cursor pos
	if not intersection.is_empty():
		var pos = intersection.position
		var look_at_mouse = Vector3(pos.x, player.position.y, pos.z)
		model.look_at(look_at_mouse, Vector3.UP)
