extends Area2D

signal hit
signal score

@export var gravity1: float = 1400.0          # Downward accel (px/s^2)
@export var flap_strength: float = -420.0    # Instant upward impulse (px/s)
@export var max_fall_speed: float = 900.0    # Terminal velocity (px/s)
@export var tilt_factor: float = 0.0025      # How much to tilt with speed
@export var isPlayerControlled = false

var velocity: Vector2 = Vector2.ZERO

func start_game():
	isPlayerControlled = true
	$CollisionShape2D.disabled = false

func _ready():
	$AnimatedSprite2D.play()

func _physics_process(delta: float) -> void:
	# Apply gravity
	velocity.y += gravity1 * delta
	
	velocity.y = clamp(velocity.y, -INF, max_fall_speed)

	# Flap on input (map "ui_accept" to Space / MouseLeft if you like)
	if isPlayerControlled && Input.is_action_just_pressed("ui_accept"):
		jump()
	elif !isPlayerControlled && position.y > 450:
		jump()
	
	if isPlayerControlled && (position.y > 725 || position.y < 0):
		isPlayerControlled = false
		hit.emit()

	# Move the Area2D by velocity (Area2D has no built-in physics motion)
	position += velocity * delta

	# Optional: tilt the sprite/node based on vertical speed (feel-good polish)
	rotation = lerp_angle(rotation, velocity.y * tilt_factor + deg_to_rad(70), 0.15)

func jump():
	velocity.y = flap_strength

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("score"):
		score.emit()
	if area.is_in_group("pipe"): 
		hit.emit()
		isPlayerControlled = false
		$CollisionShape2D.set_deferred("disabled", true)
