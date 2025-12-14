extends Node2D

@export var fire_rate := 0.4 # seconds between shots
@export var damage := 1
@export var show_range := true

@onready var range_area: Area2D = $Area2D
var _cooldown := 0.0


func _process(delta):
	_cooldown -= delta
	if _cooldown > 0.0:
		return

	var target :Node = _get_target()
	if target == null:
		return

	queue_redraw();

	target.take_damage(damage)
	_cooldown = fire_rate

func _get_target():
	var bodies := range_area.get_overlapping_bodies()
	var best = null
	var best_dist := INF
	for b in bodies:
		if not b.is_in_group("enemies"):
			continue
		var d := global_position.distance_squared_to(b.global_position)
		if d < best_dist:
			best_dist = d
			best = b
	return best

func _draw() -> void:
	if not show_range:
		return
	var shape :Shape2D= $Area2D/CollisionShape2D.shape
	if shape is CircleShape2D:
		draw_circle(Vector2.ZERO, shape.radius, Color(1, 1, 1, 0.15))
		draw_arc(Vector2.ZERO, shape.radius, 0.0, TAU, 64, Color(1, 1, 1, 0.5), 2.0)

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("ENTER:", body.name, " groups=", body.get_groups())
