extends Node

func _ready():
	get_node("MainMenu/M/VB/NewGame").pressed.connect(on_ng_pressed)
	get_node("MainMenu/M/VB/Quit").pressed.connect(on_q_pressed)

func on_ng_pressed():
	get_node("MainMenu").queue_free()
	var game_scene = load("res://Scenes/MainScenes/game_scene.tscn").instantiate()
	add_child(game_scene)

func on_q_pressed():
	get_tree().quit()

func _on_button_pressed():
	pass
