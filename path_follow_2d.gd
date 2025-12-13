extends PathFollow2D

@export var speed := 200.0 # pixels per second

var _path_len := 1.0

func _ready():
	var p := get_parent() as Path2D
	if p and p.curve:
		_path_len = max(1.0, p.curve.get_baked_length())

func _process(delta):
	progress_ratio += (speed * delta) / _path_len
	
	# reached end
	if progress_ratio >= 1.0:
		queue_free()
