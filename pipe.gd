extends Node2D

# Note: these values can be overriden by spawner
@export var speed: float = 220.0
@export var gap: float = 180.0
@export var kill_x: float = -200.0  # when left of this, delete

func setup(y_center: float) -> void:
	# Assumes Top and Bottom sprites are aligned so their openings are at y = 0
	$Top.position.y = y_center - gap * 0.5
	$Bottom.position.y = y_center + gap * 0.5

	# Stretch ScoreZone to fill the gap (optional, for scoring)
	#if $ScoreZone.has_node("CollisionShape2D"):
		#var shape := $ScoreZone/CollisionShape2D.shape as Shape2D
		#if shape is RectangleShape2D:
			#shape.size = Vector2(8, gap)  # thin vertical trigger

func _physics_process(delta: float) -> void:
	position.x -= speed * delta
	if global_position.x < kill_x:
		queue_free()
		
func _ready() -> void:
	add_to_group("pipe_pair")
