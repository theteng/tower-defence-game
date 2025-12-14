extends CharacterBody2D

@export var max_hp := 5
var hp := 0

@onready var health_bar := $HealthBar

func _ready() -> void:
	hp = max_hp
	add_to_group("enemies")
	health_bar.max_hp = max_hp
	health_bar.set_hp(hp)

func take_damage(amount: int) -> void:
	hp -= amount
	health_bar.set_hp(hp)
	if hp <= 0:
		queue_free()
