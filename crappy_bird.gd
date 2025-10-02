extends Node

var score = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_bird_hit() -> void:
	get_tree().call_group("pipe_pair", "queue_free")
	$HUD.show_game_over()
	$PipeSpawner.enabled = false

func _on_bird_score() -> void:
	score += 1
	$HUD.update_score(score)
	
#func game_over():
	#$ScoreTimer.stop()
	#$MobTimer.stop()
	#$HUD.show_game_over()
	#$Music.stop()
	#$DeathSound.play()

#func new_game():
	#score = 0
	#$Player.start($StartPosition.position)
	#$StartTimer.start()
	#$HUD.update_score(score)
	#$HUD.show_message("Get Ready")
	#$Music.play()

func start_game() -> void:
	score = 0
	$PipeSpawner.enabled = true
	$bird.start_game()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("pipe_pair", "queue_free")
