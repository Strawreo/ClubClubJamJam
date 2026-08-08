extends Node2D

const GAME_OVER= preload("res://Scenes/Menu/MinigameEndMenu.tscn")
var AppleScene = preload("res://Scenes/Minigame/Apple.tscn")

var current_apple
var index = 5

var time = 30

func _ready() -> void:
	spawn_apple()

func _process(delta: float) -> void:
	$CanvasLayer/Label.text = str(time)
	if current_apple.state == current_apple.State.EATEN:
		current_apple.reparent($Eaten)
		$Eaten.move_child(current_apple, 0)
		spawn_apple()

func spawn_apple():
	var apple = AppleScene.instantiate()
	apple.global_position = $AppleSpawn.global_position
	@warning_ignore("integer_division")
	var x_offset = ((index/5) + 1)*15
	var y_offset = -((index % 5)*10)
	apple.next_position = $AppleSpawn.global_position+Vector2(x_offset, y_offset)
	current_apple = apple
	$Eating.add_child(apple)
	index += 1

func _on_timer_timeout() -> void:
	time -= 1
	if time <= 0:
		var game_over = GAME_OVER.instantiate()
		$CanvasLayer.add_child(game_over)
		time = 0
	else:
		$Timer.start()
