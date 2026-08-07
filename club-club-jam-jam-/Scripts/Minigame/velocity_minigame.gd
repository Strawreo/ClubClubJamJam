extends Node2D

const ObstacleScene = preload("res://Scenes/Minigame/Obstacle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Spawn!")
	$ObstacleTimer.wait_time = randi_range(2,8)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_obstacle_timer_timeout() -> void:
	var obstacle = ObstacleScene.instantiate()
	obstacle.global_position = $ObstacleSpawn.global_position
	obstacle.type = randi_range(0,1)
	$ObstacleAreas.add_child(obstacle)
	$ObstacleTimer.wait_time = randi_range(1,3)
