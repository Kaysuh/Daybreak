class_name Player
extends CharacterBody3D

@export var fall_acceleration = 75
@export var max_speed = 5
@export var acceleration : int = 5
@export var friction : int = 5
@export var air_friction : int = 5
@export var particle : PackedScene

@onready var character_state_machine = $CharacterStateMachine
@onready var animation_tree = $AnimationTree
@onready var dash_timer = $DashTimer
@onready var woosh = $Woosh
@onready var punch = $Punch

var attacking := false
var direction : Vector3
var last_direction := Vector3.BACK

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	for used_particles in $Visual/ParticleSpawnPoint.get_children():
		if not used_particles.emitting:
			used_particles.queue_free()
	if direction:
		last_direction = direction
	if not is_on_floor() and dash_timer.is_stopped(): 
		velocity.y = velocity.y - (fall_acceleration * delta)
		#velocity.x = move_toward(velocity.x, 0, air_friction * delta)
		#velocity.z = move_toward(velocity.x, 0, air_friction * delta)
	if Input.is_action_just_pressed("attack") and not attacking:
		attacking = true
		velocity = last_direction
		$Visual.rotation.y =  Vector2(last_direction.z, last_direction.x).angle()
		animation_tree["parameters/playback"].travel("Punch")
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = direction.rotated(Vector3.UP, $CameraController/SpringArm3D.rotation.y)
	if not attacking:
		if input_dir:
			if !$Footsteps.playing:
				$Footsteps.play()
			
			
		if character_state_machine.can_move():
			var vel_y = velocity.y
			velocity = velocity.lerp(direction * max_speed, acceleration * delta)
			velocity.y = vel_y
		if direction:
			var look_direction = Vector2(direction.z, direction.x).angle()
			$Visual.rotation.y = lerp_angle($Visual.rotation.y, look_direction, 0.1)
		update_animation(input_dir)

	move_and_slide()
	if direction: character_state_machine.last_direction = direction

func update_animation(input_dir):
	animation_tree.set("parameters/Move/blend_position", input_dir.length())


func _attack_apex():
	velocity = velocity.lerp(Vector3.ZERO, 0.5)
	punch.pitch_scale = 1.5 + randf_range(-.1, .1)
	punch.play()

func _spawn_particles():
	var p : GPUParticles3D = particle.instantiate()
	p.emitting = true
	woosh.pitch_scale = .9 + randf_range(-.1, .1)
	woosh.play()
	$Visual/ParticleSpawnPoint.add_child(p)

func _attack_finished():
	attacking = false
