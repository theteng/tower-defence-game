extends CharacterBody2D

@export var max_hp := 5
var hp := 0

# Health bar settings
@export var bar_width := 40.0
@export var bar_height := 16.0
@export var bar_offset := Vector2(-20, -30) # left/up from enemy origin

func _ready() -> void:
	hp = max_hp
	add_to_group("enemies")
	queue_redraw()

func take_damage(amount: int) -> void:
	hp -= amount
	queue_redraw()
	if hp <= 0:
		queue_free()

func _draw() -> void:
	# Big obvious marker so we know drawing works at all
	draw_circle(Vector2.ZERO, 25.0, Color(1, 0, 0, 0.8))

	# Health bar (very large and above)
	var w := 80.0
	var h := 10.0
	var offset := Vector2(-w * 0.5, -80.0)

	var bg := Rect2(offset, Vector2(w, h))
	draw_rect(bg, Color(0, 0, 0, 0.8))

	var ratio := 0.0
	if max_hp > 0:
		ratio = clamp(float(hp) / float(max_hp), 0.0, 1.0)

	var fg := Rect2(offset, Vector2(w * ratio, h))
	draw_rect(fg, Color(0.2, 1.0, 0.2, 0.9))
