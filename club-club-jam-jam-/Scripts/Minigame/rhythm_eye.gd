extends AnimatedSprite2D
var perfect = false
var good = false
var current_note = null 
var life = 3

var score

const GAME_OVER = preload("res://Scenes/Menu/MinigameEndMenu.tscn")
@export var input = ""

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Action_Button",false):
		frame = 1
		print("Rhythm Eye Activated")
		if current_note != null:
			if perfect:
				get_parent().increment_score(2)
				current_note.destroy(2)
				_reset()
			elif good:
				get_parent().increment_score(1)
				current_note.destroy(1)
				_reset()
		else:
			self.lose_life()
			get_parent().increment_score(0)
				
	elif event.is_action_released("Action_Button"):
		$PushTimer.start()	
		frame = 0 	

func update_score(new_score):
	score = new_score

func lose_life():
	life -= 1
	
	var life_meter = get_parent().get_node("LifeMeter")
	life_meter.frame += 1  
	if life == 0:
		life = 0 
		Global.retry_scene_path = "res://Scenes/Minigame/ReactionMinigame.tscn"
		var game_over = GAME_OVER.instantiate()
		game_over.attribute = "Reaction"
		game_over.score = score
		get_parent().add_child(game_over)
		queue_free()

func _on_push_timer_timeout() -> void:
	frame = 0

func _reset():
	current_note = null
	perfect = false
	good = false
	

func _on_good_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Note"):
		current_note = area
		good = true 
		print("Good area entered")
		


func _on_good_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("Note"):
		good = false
		current_note = null
		print("Good area exited")

func _on_perfect_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Note"):
		perfect = true
		print("Perfect area entered")
		
func _on_perfect_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("Note"):
		perfect = false
		print("Perfect area exited")
