extends Area2D

const TARGET_X = -111
const SPAWN_X = 200
const DIST_TO_TARGET = TARGET_X - SPAWN_X

const LANE = Vector2(SPAWN_X, 50)

var speed = 0 
var hit = false

func _ready() -> void:
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not hit:
		position.x += speed * delta
		if position.x < -200:
			get_tree().call_group("minigame", "increment_score", 0)
			queue_free()

func initialize():
	$AnimatedSprite2D.frame = 0 
	position = LANE
	speed = DIST_TO_TARGET / 2.0
	print(" Note spawned")

func destroy(score):
	$AnimatedSprite2D.visible = false
	$Timer.start()
	hit = true
	if score == 2:
		$Node2D/Label.text = "Perfect"
		$Node2D/Label.modulate = Color("f7b69e")
	if score == 1:
		$Node2D/Label.text = "Good"
		$Node2D/Label.modulate = Color("f7b69e")	


func _on_timer_timeout() -> void:
	queue_free()
