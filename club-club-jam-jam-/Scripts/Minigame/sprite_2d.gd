extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.player_shell == "Cap":
		texture = load("res://Assets/Sprites/Shells/CapIsolated.png")
	elif Global.player_shell == "Soft":
		texture = load("res://Assets/Sprites/Shells/SoftShellIsolated.png")
	elif Global.player_shell == "Cone":
		texture = load("res://Assets/Sprites/Shells/ConeIsolated.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
