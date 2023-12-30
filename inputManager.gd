extends Node

func _process(_delta):
	if Input.get_connected_joypads().size() > 0:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
