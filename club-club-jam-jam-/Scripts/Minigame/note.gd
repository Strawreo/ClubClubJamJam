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
			get_tree().call_group("rhythmEye", "lose_life")
			print("Note left playable Area")
			queue_free()

func initialize():
	$AnimatedSprite2D.frame = 0 
	position = LANE
	hit = false
	speed = DIST_TO_TARGET / 2.0
	$CollisionShape2D.set_deferred("disabled",false)
	print("Note spawned")

func destroy(score):
	hit = true
	$CollisionShape2D.set_deferred("disabled",true )
	$AnimatedSprite2D.visible = false	
	if score == 2:
		$Node2D/Label.text = "Perfect"
		$Node2D/Label.modulate = Color("f7b69e")
		print("Got note perfect")
	if score == 1:
		$Node2D/Label.text = "Good"
		$Node2D/Label.modulate = Color("f7b69e")	
		print("Got note good")
	$Timer.start()


func _on_timer_timeout() -> void:
	queue_free()
