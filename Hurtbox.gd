class_name Hurtbox
extends Area3D

func _init():
	collision_layer = 0
	collision_mask = 2

func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: Hitbox) -> void:
	if not hitbox:
		return
	var impact_point :=  hitbox.global_position - global_position
	var force := -impact_point
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage, force * 50)
