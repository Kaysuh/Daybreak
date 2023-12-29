extends State
class_name AirState

@export var ground_state : State
@onready var character_state_machine = $".."
var dash_speed = 400

func state_process(_delta):
	if(character.is_on_floor()):
		playback.travel("Move")
		next_state = ground_state

func on_enter():
	can_move = false

#func state_input(event : InputEvent):
	#if(event.is_action_pressed("jump")):
		#dash()
#
#func dash():
	#character.velocity.x = character_state_machine.last_direction.x * dash_speed * 2
	#character.velocity.y = character_state_machine.last_direction.y * dash_speed * 2
