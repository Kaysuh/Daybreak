extends Node3D

@onready var pause_menu = $PauseMenu
@onready var boons = $Boons
@onready var desert_wind = $DesertWind
@onready var music = $Music

var paused = false

func _process(_delta):
	if !desert_wind.playing:
		desert_wind.play()
	if !music.playing:
		music.play()
	if (Input.is_action_just_pressed("esc")):
		pauseMenu()
		if Input.get_connected_joypads().size() > 0:
			$PauseMenu/PauseMenu/Continue.grab_focus()
	if (Input.is_action_just_pressed("boon_test")):
		print("here")
		$Boons.show()
		$Boons/SunBoon.show()
		$Boons/SunBoon/TextureButton.show()
	
func pauseMenu():
	if paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		pause_menu.hide()
	else:
		pause_menu.show()
		if !Input.get_connected_joypads().size() > 0:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	paused = !paused
	get_tree().paused = paused
