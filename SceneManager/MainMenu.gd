extends Control
class_name menu

func _ready():
	if Input.get_connected_joypads().size() > 0:
		$Menu/Play.grab_focus()

#func _process(_delta):
	#if Input.is_anything_pressed():
		#$Start.hide()
		#$Menu.show()
		
func _on_quit_button_down():
	SceneManager.QuitGame()

func _on_play_button_down():
	SceneManager.SwitchScene("Main")

func _on_start_button_down():
	SceneManager.SwitchScene("Main")
