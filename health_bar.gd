extends Node2D

@export var max_hp := 5
var hp := 5

func set_hp(value: int) -> void:
	hp = value
	queue_redraw()

func _draw() -> void:
	var w := 500.0
	var h := 35.0
	var offset := Vector2(-w * 0.5, -160.0)

	# background
	draw_rect(Rect2(offset, Vector2(w, h)), Color(0, 0, 0, 0.75))

	# fill
	var ratio :float= clamp(float(hp) / float(max_hp), 0.0, 1.0)
	draw_rect(Rect2(offset, Vector2(w * ratio, h)), Color(0.2, 1.0, 0.2, 0.9))

func _ready() -> void:
	# Counter enemy visual scale so the bar stays readable
	var parent_scale :Vector2= get_parent().scale
	if parent_scale.x != 0:
		scale = Vector2.ONE / parent_scale
