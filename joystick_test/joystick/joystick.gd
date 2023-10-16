extends Control

var start_pos: Vector2 = Vector2.ZERO
var end_pos: Vector2 = Vector2.ZERO
var valid_pos = false
onready var js_pos = get_node("background").rect_position
onready var js_bg = get_node("background")
onready var js_handle = get_node("background/handle")

signal swipe_detect(swipe_direction, strength)
signal swipe_end

func _input(event: InputEvent) -> void:
	if valid_pos:
		if event is InputEventScreenDrag:
			if start_pos == Vector2.ZERO:
				start_pos = event.position
			end_pos = event.position
			var direction = end_pos - start_pos
			if direction.length() < 120:
				js_handle.rect_position.x = 48 + direction.length()
				js_handle.rect_pivot_offset.x = 48 - direction.length()
			js_handle.rect_rotation = rad2deg(direction.angle())
			emit_signal("swipe_detect",direction, direction.length())

func _on_TextureButton_button_down() -> void:
	valid_pos = true

func _on_TextureButton_button_up() -> void:
	emit_signal("swipe_end")
	js_bg.rect_position = js_pos
	start_pos = Vector2.ZERO
	end_pos = Vector2.ZERO
	valid_pos = true
