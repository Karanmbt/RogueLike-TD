extends Node

func _ready():
	load_main_menu()

func load_main_menu():
	get_node("MainMenu/M/VB/NewGame").pressed.connect(on_ng_pressed)
	get_node("MainMenu/M/VB/Quit").pressed.connect(on_q_pressed)

func on_ng_pressed():
	get_node("MainMenu").queue_free()
	var game_scene = load("res://Scenes/MainScenes/game_scene.tscn").instantiate()
#	game_scene.game_finished.connect(unload_game)
	add_child(game_scene)

func on_q_pressed():
	get_tree().quit()

"""
func unload_game():
	get_node('GameScene').queue_free()
	var main_menu = load("res://main_menu.tscn").instantiate()
	add_child(main_menu)
	load_main_menu()
"""
