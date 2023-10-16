extends KinematicBody2D

var direction = Vector2.ZERO
var speed = 300



func _process(delta: float) -> void:
	move_and_slide(direction * speed)

func _on_joystick_swipe_detect(swipe_direction, strength) -> void:
	direction = swipe_direction.normalized()
	$".".rotation_degrees = rad2deg(swipe_direction.angle())
	if strength < 300:
		speed = strength

func _on_joystick_swipe_end() -> void:
	direction = Vector2.ZERO
