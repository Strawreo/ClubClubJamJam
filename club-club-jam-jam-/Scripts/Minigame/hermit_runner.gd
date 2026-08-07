extends CharacterBody2D

const SPEED = 200.0
const MAX_JUMP_VELOCITY = -300.0
const MIN_JUMP_VELOCITY = -200.0
const GAME_OVER= preload("res://Scenes/Menu/MinigameEndMenu.tscn")


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("Action_Button") and is_on_floor():
		velocity.y = MIN_JUMP_VELOCITY
	if Input.is_action_pressed("Action_Button") and velocity.y > MAX_JUMP_VELOCITY:
		velocity.y -= 10

	#var direction := Input.get_axis("left", "right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_death_area_area_entered(area: Area2D) -> void:
	hide()
	Global.retry_scene_path = "res://Scenes/Minigame/VelocityMinigame.tscn"
	var game_over= GAME_OVER.instantiate()
	get_parent().add_child(game_over)
	queue_free()
	
