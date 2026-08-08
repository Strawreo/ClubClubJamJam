extends Node2D

enum State { APPEARING, EATING, EATEN }
var state: State = State.APPEARING

var condition = 20
var next_position

func _ready() -> void:
	$Sprite2D.visible = false
	$AnimationPlayer.play("Appear")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Action_Button") and state == State.EATING:
		take_damage()
		$AnimationPlayer.stop()
		$AnimationPlayer.play("Shaking")
	if condition <= 0 and state != State.EATEN:
		eaten()

func take_damage():
	condition -= 1

func eaten():
	$AnimationPlayer.stop()
	$Sprite2D.visible = false
	$Sprite2D.frame = 1
	global_position = next_position
	state = State.EATEN
	$AnimationPlayer.play("Eaten")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if state == State.APPEARING:
		state = State.EATING
	$AnimationPlayer.play("Idle")
