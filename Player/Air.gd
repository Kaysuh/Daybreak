extends State
class_name AirState

@export var ground_state : State
@onready var character_state_machine = $".."
@export var dash_speed = 20
@export var dash_timer = 0.5
@onready var timer = $"../../DashTimer"

func state_process(_delta):
	if(character.is_on_floor()):
		playback.travel("Move")
		next_state = ground_state
	if timer.time_left == 0:
		can_move = true
		timer.stop()
		owner.visible = true
	print(timer.time_left)

func on_enter():
	can_move = true

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		dash()

func dash():
	timer.start(dash_timer)
	can_move = false
	owner.visible = false
	character.velocity.x = character_state_machine.last_direction.x * dash_speed 
	character.velocity.z = character_state_machine.last_direction.z * dash_speed
	character.velocity.y = 0
