extends Area2D

const SPEED = 80
const TEXTURES = [
	preload("res://Assets/Sprites/SeaGlassRed.png"),
	preload("res://Assets/Sprites/SeaGlassDarkGreen.png"),
	preload("res://Assets/Sprites/SeaGlassGreen.png")
]
enum Type { SINGLE, DOUBLE }
var type: Type

func _ready() -> void:
	match type:
		Type.SINGLE:
			$DoubleSprite.visible = false
			$DoubleArea.disabled = true
			$SingleSprite.texture = TEXTURES.pick_random()
		Type.DOUBLE:
			pass

func _physics_process(delta: float) -> void:
	position.x -= SPEED * delta

func _on_death_timer_timeout() -> void:
	queue_free();
