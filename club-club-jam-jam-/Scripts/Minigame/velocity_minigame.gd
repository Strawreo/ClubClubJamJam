extends Node2D
const OBSTACLE_SCENE= preload("res://Scenes/Minigame/Obstacle.tscn")

func _ready() -> void:
	print("Spawn!")
	$ObstacleTimer.wait_time = randi_range(2,8)


func _on_obstacle_timer_timeout() -> void:
	var obstacle = OBSTACLE_SCENE.instantiate()
	obstacle.global_position = $ObstacleSpawn.global_position
	obstacle.type = randi_range(0,1)
	$ObstacleAreas.add_child(obstacle)
	$ObstacleTimer.wait_time = randi_range(1,3)
