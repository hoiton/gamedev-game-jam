extends Area2D

signal hit

@export var gravity1: float = 1400.0          # Downward accel (px/s^2)
@export var flap_strength: float = -420.0    # Instant upward impulse (px/s)
@export var max_fall_speed: float = 900.0    # Terminal velocity (px/s)
@export var tilt_factor: float = 0.0025      # How much to tilt with speed

var velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	# Apply gravity
	velocity.y += gravity1 * delta
	
	velocity.y = clamp(velocity.y, -INF, max_fall_speed)

	# Flap on input (map "ui_accept" to Space / MouseLeft if you like)
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = flap_strength

	# Move the Area2D by velocity (Area2D has no built-in physics motion)
	position += velocity * delta

	# Optional: tilt the sprite/node based on vertical speed (feel-good polish)
	rotation = lerp_angle(rotation, velocity.y * tilt_factor, 0.15)


func _on_body_entered(body: Node2D) -> void:
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
