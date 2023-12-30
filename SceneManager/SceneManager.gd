extends Control
class_name nSceneManager
 
@export var Scenes : Dictionary = {}
 
var Current_scene : String = ""

func _ready() -> void:
	var mainScene : StringName = ProjectSettings.get_setting("application/run/main_scene")
	Current_scene = Scenes.find_key(mainScene)

func AddScene(sceneName : String, scenePath : String) -> void:
	Scenes[sceneName] = scenePath
 
func RemoveScene(sceneName : String) -> void:
	Scenes.erase(sceneName)

func SwitchScene(sceneName : String) -> void:
	get_tree().change_scene_to_file(Scenes[sceneName])
	Current_scene = sceneName
 
func RestartScene() -> void:
	get_tree().reload_current_scene()

func QuitGame() -> void:
	get_tree().quit()

func GetSceneCount() -> int:
	return Scenes.size()

func GetCurrentSceneAlias() -> String:
	return Current_scene
