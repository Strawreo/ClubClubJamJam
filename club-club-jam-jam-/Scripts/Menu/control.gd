extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for button in get_tree().get_nodes_in_group("Button"):
		if (button is Button):
			button.pressed.connect(on_button_pressed.bind(button))
			button.mouse_exited.connect(mouse_interaction.bind(button,"exited"))
			button.mouse_entered.connect(mouse_interaction.bind(button,"entered"))
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_button_pressed(button: Button) -> void:
	match button.name:
		"VelocityMinigame":
			get_tree().change_scene_to_file("res://Scenes/Minigame/VelocityMinigame.tscn")
		"IntegrityMinigame":
			get_tree().change_scene_to_file("res://Scenes/Minigame/IntegrityMinigame.tscn")
		"ReactionMinigame":
			get_tree().change_scene_to_file("res://Scenes/Minigame/ReactionMinigame.tscn")
		"StoreButton":
			get_tree().change_scene_to_file("res://Scenes/Menu/StoreScene.tscn")
		"PlayButton":
			get_tree().change_scene_to_file("res://Scenes/Course/CourseScene.tscn")
		

func mouse_interaction(button: Button, state: String) -> void:
	pass
