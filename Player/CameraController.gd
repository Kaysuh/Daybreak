extends Node3D

@export var mouse_sensitivity := .1
@export var upper_tilt_limit := deg_to_rad(45)
@export var lower_tilt_limit := deg_to_rad(-60)

@onready var arm := $SpringArm3D

var yaw_rotation : float
var pitch_rotation : float


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		yaw_rotation = -event.relative.x * mouse_sensitivity
		pitch_rotation = -event.relative.y * mouse_sensitivity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	yaw_rotation += Input.get_action_raw_strength("camera_left") - Input.get_action_raw_strength("camera_right")
	pitch_rotation += Input.get_action_raw_strength("camera_up") - Input.get_action_raw_strength("camera_down")
	
	arm.rotation.y += yaw_rotation * delta
	arm.rotation.y = wrapf(arm.rotation.y, deg_to_rad(0), deg_to_rad(360))
	arm.rotation.x += pitch_rotation * delta
	arm.rotation.x = clamp(arm.rotation.x, lower_tilt_limit, upper_tilt_limit)
	
	yaw_rotation = 0
	pitch_rotation = 0
