extends Control
class_name menu

func _ready():
	if Input.get_connected_joypads().size() > 0:
		$Menu/Play.grab_focus()

func _on_quit_button_down():
	SceneManager.QuitGame()

func _on_play_button_down():
	SceneManager.SwitchScene("Main")

func _on_start_button_down():
	SceneManager.SwitchScene("Main")
