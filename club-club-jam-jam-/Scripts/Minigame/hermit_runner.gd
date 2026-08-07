extends CharacterBody2D

const SPEED = 200.0
const MAX_JUMP_VELOCITY = -300.0
const MIN_JUMP_VELOCITY = -200.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = MIN_JUMP_VELOCITY
	if Input.is_action_pressed("up") and velocity.y > MAX_JUMP_VELOCITY:
		velocity.y -= 8

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_death_area_area_entered(area: Area2D) -> void:
	queue_free()
