extends Node2D

signal game_finished(result)


var map_node 

var build_mode= false
var build_valid = false
var build_tile 
var build_location
var build_type

var current_wave = 0
var enemies_in_wave = 0


var base_health = 100


func _ready():
	map_node = get_node("Map1")
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.pressed.connect(initiate_build_mode.bind(i.name))
		
	
func _process(delta):
	if build_mode:
		update_tower_preview()
#print(base_health)
	
func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	if event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
		cancel_build_mode()


###################################################################################################

##
# Wave functions below
##

func start_next_wave():
	var wave_data = retrieve_wave_data()
	await get_tree().create_timer(0.2).timeout
	spawn_enemies(wave_data)
	

func retrieve_wave_data():
	var wave_data = [['BlueTank', 0.5], ['BlueTank', 0.5], ['BlueTank', 0.5], ['BlueTank', 0.5], ['BlueTank', 0.5], ['BlueTank', 0.5], ['BlueTank', 0.5]]
	current_wave += 1
	enemies_in_wave = wave_data.size()
	return wave_data
	
	
func spawn_enemies(wave_data):
	for i in wave_data:
		var new_enemy = load('res://Scenes/Enemies/' + i[0] + '.tscn').instantiate()
#		new_enemy.base_damage.connect(on_base_damage)
		map_node.get_node('Path').add_child(new_enemy, true)
		await get_tree().create_timer(i[1]).timeout
		


##
# Wave functions end above
##

###################################################################################################

##
# Build tower functions below
##

func initiate_build_mode(tower_type):
	if build_mode:
		cancel_build_mode()
	build_type = tower_type + "T1"
	build_mode = true 
	get_node("UI").set_tower_preview(build_type, get_global_mouse_position())
	

func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("TowerExclusion").local_to_map(mouse_position)
	var title_position = map_node.get_node("TowerExclusion").map_to_local(current_tile)
	
	if map_node.get_node("TowerExclusion").get_cell_source_id(0, current_tile) == -1:
		get_node("UI").update_tower_preview(title_position, "41fe8d")
		build_valid = true 
		build_location = title_position
		build_tile = current_tile
	
	else:
		get_node("UI").update_tower_preview(title_position, "ff4b4e")
		build_valid = false
		

func cancel_build_mode():
	build_mode = false 
	build_valid = false 
	get_node("UI/TowerPreview").free()

func verify_and_build():
	if build_valid:
		# Test for enough cash
		var new_tower = load("res://Scenes/Turret/" + build_type + ".tscn").instantiate()
		new_tower.position = build_location
		new_tower.built = true
		new_tower.type = build_type
		new_tower.category = GameData.tower_data[build_type]["category"]
		map_node.get_node("Turrets").add_child(new_tower, true)
		map_node.get_node("TowerExclusion").set_cell(0, build_tile, 5, Vector2(1, 0))
		# -- the Cash amount
		# Update the Cash Lable

##
# Build tower functions end above
##


func on_base_damage(damage):
	base_health -= damage
	if base_health <= 0:
		emit_signal('game_finished', false)
	else:
		get_node('UI').update_health_bar(base_health)
