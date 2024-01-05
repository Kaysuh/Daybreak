extends CharacterBody3D

@export var speed := 3
@export var acceleration := 10
@export var health := 15

@onready var animation_player := $AnimationPlayer
@onready var knockback_timer := $Knockback

var target : CharacterBody3D

func take_damage(amount: int, knockback : Vector3) -> void:
	animation_player.play("hurt")
	health -= amount
	velocity = knockback
	knockback_timer.start(.1)
	if health <= 0:
		queue_free()

func _process(delta):
	if knockback_timer.is_stopped():
		if target:
			var look_direction := target.global_position
			if look_direction:
				look_at(look_direction)
			var direction = (target.position - position).normalized()
			velocity = velocity.lerp(direction * speed, acceleration * delta)
		else:
			velocity = velocity.lerp(Vector3.ZERO, acceleration * delta)
	move_and_slide()


func _on_player_detection_area_body_entered(body):
	if body is Player:
		target = body
		animation_player.play("player_detected")


func _on_player_detection_area_body_exited(body):
	if body is Player:
		target = null
		animation_player.play("player_lost")
