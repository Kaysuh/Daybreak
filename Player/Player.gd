extends CharacterBody3D

@onready var character_state_machine = $CharacterStateMachine
@onready var animation_tree = $AnimationTree
@export var fall_acceleration = 75
@export var max_speed = 7
@export var acceleration : int = 800
@export var friction : int = 800
@export var air_friction : int = 200

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	if not is_on_floor(): 
		velocity.y = velocity.y - (fall_acceleration * delta)
		velocity.x = move_toward(velocity.x, 0, air_friction * delta)
		velocity.z = move_toward(velocity.x, 0, air_friction * delta)

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction and character_state_machine.can_move():
		velocity.x = move_toward(velocity.x, max_speed * direction.x, acceleration * delta)
		velocity.x = clamp(velocity.x, -max_speed, max_speed)
		velocity.z = move_toward(velocity.z, max_speed * direction.z, acceleration * delta)
		velocity.z = clamp(velocity.z, -max_speed, max_speed)
		
	if direction != Vector3.ZERO:
		var look_direction = Vector2(direction.z, direction.x).angle()
		$Armature.rotation.y = lerp_angle($Armature.rotation.y, look_direction, 0.1)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		velocity.z = move_toward(velocity.z, 0, friction * delta)

	move_and_slide()
	update_animation(input_dir)
	character_state_machine.last_direction = input_dir
	#print(character_state_machine.last_direction)

func update_animation(input_dir):
	animation_tree.set("parameters/Move/blend_position", input_dir.length())
