extends State
class_name AirState

@export var ground_state : State
@onready var character_state_machine = $".."
@export var dash_speed = 20
@export var dash_timer = 0.6
@export var dash_count = 1
@onready var timer = $"../../DashTimer"
@onready var vfx_anim_player = $"../../VfxAnimPlayer"

var dash_counter = dash_count

func state_process(_delta):
	$"../../Footsteps".stop()
	if(character.is_on_floor()):
		playback.travel("Move")
		dash_counter = dash_count
		next_state = ground_state
	if timer.time_left == 0:
		can_move = true
		timer.stop()

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump") and dash_counter > 0 and timer.time_left == 0):
		dash_counter = dash_counter - 1
		dash()

func dash():
	$"../../Dash".play()
	vfx_anim_player.play("DashVfx")
	timer.start(dash_timer)
	can_move = false
	character.velocity.x = character_state_machine.last_direction.x * dash_speed 
	character.velocity.z = character_state_machine.last_direction.z * dash_speed
	character.velocity.y = 0
