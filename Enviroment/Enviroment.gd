extends Node3D

@export var enemy_scene : PackedScene

@onready var spawn_timer = $SpawnTimer

func _on_spawn_timer_timeout():
	# Create a new instance of the Mob scene.
	var enemy = enemy_scene.instantiate()

	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var spawn_location = get_node("SpawnPath/SpawnLocation")
	# And give it a random offset.
	spawn_location.progress_ratio = randf()
	enemy.position = spawn_location.position

	# Spawn the mob by adding it to the Main scene.
	add_child(enemy)
