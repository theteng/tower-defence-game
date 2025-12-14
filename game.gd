extends Node2D

@export var enemy_scene: PackedScene
@export var enemies_in_wave := 25
@export var spawn_delay := 2.5
@export var follower_scene: PackedScene
@export var tower_scene: PackedScene
@export var placement_enabled := true

@onready var path := $Path2D

func _ready():
	start_wave()

func start_wave():
	for i in enemies_in_wave:
		await get_tree().create_timer(spawn_delay).timeout
		spawn_enemy()

func spawn_enemy():
	var follower := follower_scene.instantiate()
	follower.loop = false
	path.add_child(follower)

	var enemy := enemy_scene.instantiate()
	enemy.position = Vector2.ZERO
	follower.add_child(enemy)

func _unhandled_input(event):
	if not placement_enabled:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var tower := tower_scene.instantiate()
		tower.global_position = get_global_mouse_position()
		add_child(tower)
