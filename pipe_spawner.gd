extends Node2D

@export var pipe_scene: PackedScene
@export var spawn_x: float = 800.0        # screen-right spawn position (global)
@export var min_y: float = 140.0          # allowed center range
@export var max_y: float = 460.0
@export var gap: float = 350.0
@export var speed: float = 150.0
@export var spawn_interval: float = 2.25  # seconds
@export var enabled = false

var _timer := 0.0
var _rng := RandomNumberGenerator.new()

func _ready() -> void:
	_rng.randomize()

func _process(delta: float) -> void:
	_timer += delta
	if _timer >= spawn_interval:
		_timer = 0.0
		_spawn_pipes()

func _spawn_pipes() -> void:
	if !enabled:
		return
	var p := pipe_scene.instantiate()
	get_tree().current_scene.add_child(p)
	p.global_position = Vector2(spawn_x, 0.0)
	p.speed = speed
	p.gap = gap
	var y_center := _rng.randf_range(min_y, max_y)
	p.setup(y_center)
