extends CanvasLayer

var score: int
var attribute: String

var direction = Global.retry_scene_path

func _ready() -> void:
	for button in get_tree().get_nodes_in_group("Button"):
		button.pressed.connect(on_button_pressed.bind(button))
		button.mouse_exited.connect(mouse_interaction.bind(button,"exited"))
		button.mouse_entered.connect(mouse_interaction.bind(button,"entered"))
	@warning_ignore("integer_division")
	var addition = 0
	if score != null:
		match attribute:
			"Velocity":
				addition = (score/8)
				Global.velocity += addition
			"Integrity":
				addition = (score/5)
				Global.integrity += addition
			"Reaction":
				addition = (score/200)
				Global.reaction += addition
	$VBoxContainer/Attribute.text = attribute+" gained: "+str(addition)

func on_button_pressed(button: Button) -> void:
	match button.name:
		"Play": 
			var _game: bool = get_tree().change_scene_to_file("res://Scenes/Menu/Main.tscn")
		"Retry":
			var _retry: bool = get_tree().change_scene_to_file(direction)

func mouse_interaction(button: Button, state: String) -> void:
	match state:
		"exited":
			button.modulate.a = 1
		"entered":
			button.modulate.a = 0.5
