extends Control
const MINIGAME_COST: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for button in get_tree().get_nodes_in_group("Button"):
		if (button is Button):
			button.pressed.connect(on_button_pressed.bind(button))
			button.mouse_exited.connect(mouse_interaction.bind(button,"exited"))
			button.mouse_entered.connect(mouse_interaction.bind(button,"entered"))
	$Attributes/VBoxContainer/Integrity.text = "Integrity: "+str(Global.integrity)
	$Attributes/VBoxContainer/Reaction.text = "Reaction: "+str(Global.reaction)
	$Attributes/VBoxContainer/Velocity.text = "Velocity: "+str(Global.velocity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_button_pressed(button: Button) -> void:
	match button.name:
		"VelocityMinigame":
			_try_start_minigame("res://Scenes/Minigame/VelocityMinigame.tscn", MINIGAME_COST)
		"IntegrityMinigame":
			_try_start_minigame("res://Scenes/Minigame/IntegrityMinigame.tscn", MINIGAME_COST)
		"ReactionMinigame":
			_try_start_minigame("res://Scenes/Minigame/ReactionMinigame.tscn", MINIGAME_COST)
		"StoreButton":
			get_tree().change_scene_to_file("res://Scenes/Menu/StoreScene.tscn")
		"PlayButton":
			get_tree().change_scene_to_file("res://Scenes/Course/CourseScene.tscn")
		

func mouse_interaction(button: Button, state: String) -> void:
	pass
func _try_start_minigame(scene_path: String,cost:int) -> void:
	if Global.quantity_shells>=cost:
		Global.quantity_shells-=cost
		Global.save_game()
	else:
		print("Fragmentos insuficientes! Custo fixo: ", cost, " | Saldo atual: ", Global.quantity_shells)
