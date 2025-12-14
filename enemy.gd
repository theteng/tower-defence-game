extends CharacterBody2D

@export var max_shield := 8
@export var max_hp := 12

# Shield behaviour
@export var shield_damage_multiplier := 1.0 
@export var shield_regen_per_sec := 0.5
@export var shield_regen_delay := 2.0

var shield := 0
var hp := 0
var _time_since_hit := 999.0

@onready var shield_bar: HealthBar2D = $Bars/ShieldBar
@onready var hull_bar: HealthBar2D = $Bars/HullBar
@onready var shield_sprite: Sprite2D = $Visuals/ShieldSprite
@onready var shield_fx: AnimationPlayer = $Visuals/ShieldHitFX

func _ready() -> void:
	add_to_group("enemies")

	shield = max_shield
	hp = max_hp

	shield_bar.set_max(max_shield)
	shield_bar.set_value(shield)
	hull_bar.set_max(max_hp)
	hull_bar.set_value(hp)

	_update_shield_visual()

func _process(delta: float) -> void:
	_time_since_hit += delta

	if shield_regen_per_sec > 0.0 and shield < max_shield and _time_since_hit >= shield_regen_delay:
		var before := shield
		shield = min(max_shield, shield + int(ceil(shield_regen_per_sec * delta)))
		if shield != before:
			shield_bar.set_value(shield)
			_update_shield_visual()

func take_damage(amount: int) -> void:
	_time_since_hit = 0.0

	var remaining := amount

	# 1) Shield absorbs first
	if shield > 0:
		var effective := int(ceil(float(remaining) * shield_damage_multiplier))
		var absorbed = min(shield, effective)
		shield -= absorbed
		remaining = max(0, remaining - int(ceil(float(absorbed) / max(shield_damage_multiplier, 0.0001))))

		shield_bar.set_value(shield)
		_update_shield_visual()
		_play_shield_hit()

	# 2) Hull takes leftover
	if remaining > 0:
		hp -= remaining
		hull_bar.set_value(hp)

		if hp <= 0:
			queue_free()

func _update_shield_visual() -> void:
	shield_sprite.visible = shield > 0
	if max_shield > 0:
		var ratio := float(shield) / float(max_shield)
		shield_sprite.modulate.a = lerp(0.25, 0.85, ratio)

func _play_shield_hit() -> void:
	if shield_sprite.visible and shield_fx:
		shield_fx.play("hit")
