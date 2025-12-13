extends Node2D

@export var enemy_scene: PackedScene
@export var enemies_in_wave := 5
@export var spawn_delay := 0.8
@export var follower_scene: PackedScene

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
