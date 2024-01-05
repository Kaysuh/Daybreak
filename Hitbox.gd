class_name Hitbox
extends Area3D

@export var damage := 5

func _init():
	collision_layer = 2
	collision_mask = 0
