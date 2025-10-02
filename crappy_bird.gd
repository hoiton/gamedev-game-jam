extends Node

var score = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Music.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_bird_hit() -> void:
	get_tree().call_group("pipe_pair", "queue_free")
	$HUD.show_game_over()
	$PipeSpawner.enabled = false
	#$Music.stop()
	$DeathSound.play()

func _on_bird_score() -> void:
	score += 1
	$HUD.update_score(score)
	
func start_game() -> void:
	score = 0
	$PipeSpawner.enabled = true
	$bird.start_game()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("pipe_pair", "queue_free")
