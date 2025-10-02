extends Node2D

@onready var bg1 = $TextureRect
@onready var bg2 = $TextureRect2

var start_x

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_x = bg2.position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	bg1.position.x -= 1
	bg2.position.x -= 1
	
	if bg1.position.x <= -1728:
		bg1.position.x = start_x
	if bg2.position.x <= -1728:
		bg2.position.x = start_x
