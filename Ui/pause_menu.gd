extends Control

@onready var main = $".."

func _on_continue_pressed():
	main.pauseMenu()

func _on_quit_to_menu_pressed():
	get_tree().paused = false
	SceneManager.SwitchScene("Menu")
