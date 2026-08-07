extends AnimatedSprite2D
var perfect = false
var good = false
var current_note = null 
var life = 3

const GAME_OVER= preload("res://Scenes/Menu/MinigameEndMenu.tscn")
@export var input = ""

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Action_Button",false):
		frame = 1
		if current_note != null:
			if perfect:
				get_parent().increment_score(1)
				current_note.destroy()
			elif good:
				get_parent().increment_score(0)
				current_note.destroy()
				_reset()
		else:
			self.lose_life()
				
	elif event.is_action_released("Action_Button"):
		$PushTimer.start()	
		frame = 0 	

func lose_life():
	life -= 1
	if life == 0:
		life = 0 
		Global.retry_scene_path = "res://Scenes/Minigame/ReactionMinigame.tscn"
		var game_over = GAME_OVER.instantiate()
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
		good = true 
		current_note = area


func _on_good_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("Note"):
		good = false
		current_note = null

func _on_perfect_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Note"):
		perfect = true
		
func _on_perfect_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("Note"):
		perfect = false
