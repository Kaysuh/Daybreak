extends State
class_name GroundState

@export var air_state : State
@export var jump_force = 40
@export var jump_buffer = 0.2
@export var animation_tree : AnimationTree
@onready var land = $"../../Land"

var jump_timer = 0.0

func state_process(delta):
	jump_timer -= delta
	if(!character.is_on_floor()):
		next_state = air_state
func on_enter():
	land.play()
	
func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump_timer = jump_buffer
		if jump_timer > 0:
			jump()

func jump():
	character.velocity.y = jump_force
	next_state = air_state
	playback.travel("Jump")
	animation_tree["parameters/Jump/TimeScale/scale"] = 2

