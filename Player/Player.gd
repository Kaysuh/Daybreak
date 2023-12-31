extends CharacterBody3D

@onready var character_state_machine = $CharacterStateMachine
@onready var animation_tree = $AnimationTree
@export var fall_acceleration = 75
@export var max_speed = 5
@export var acceleration : int = 5
@export var friction : int = 5
@export var air_friction : int = 5
@onready var dash_timer = $DashTimer

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	if not is_on_floor() and dash_timer.is_stopped(): 
		velocity.y = velocity.y - (fall_acceleration * delta)
		#velocity.x = move_toward(velocity.x, 0, air_friction * delta)
		#velocity.z = move_toward(velocity.x, 0, air_friction * delta)
	
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = direction.rotated(Vector3.UP, $CameraController/SpringArm3D.rotation.y)
	if input_dir:
		if !$Footsteps.playing:
			$Footsteps.play()
		
		
	if character_state_machine.can_move():
		var vel_y = velocity.y
		velocity = velocity.lerp(direction * max_speed, acceleration * delta)
		velocity.y = vel_y
	if direction:
		var look_direction = Vector2(direction.z, direction.x).angle()
		$Armature.rotation.y = lerp_angle($Armature.rotation.y, look_direction, 0.1)

	move_and_slide()
	update_animation(input_dir)
	if direction: character_state_machine.last_direction = direction

func update_animation(input_dir):
	animation_tree.set("parameters/Move/blend_position", input_dir.length())
