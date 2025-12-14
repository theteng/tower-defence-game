extends Node2D
class_name HealthBar2D

@export var max_value := 10
@export var width := 400.0
@export var height := 20.0
@export var y_offset := -50.0

@export var background_color: Color = Color(0, 0, 0, 0.75)
@export var fill_color: Color = Color(0.2, 1.0, 0.2, 0.9)

var value := 10

func set_value(v: int) -> void:
	value = clamp(v, 0, max_value)
	queue_redraw()

func set_max(v: int) -> void:
	max_value = max(v, 1)
	value = clamp(value, 0, max_value)
	queue_redraw()

func _draw() -> void:
	var offset := Vector2(-width * 0.5, y_offset)
	draw_rect(Rect2(offset, Vector2(width, height)), background_color)

	var ratio :float= clamp(float(value) / float(max_value), 0.0, 1.0)
	draw_rect(Rect2(offset, Vector2(width * ratio, height)), fill_color)
