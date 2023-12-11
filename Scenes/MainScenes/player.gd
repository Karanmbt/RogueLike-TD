extends Area2D


var bullet_speed = 200  # Adjust the speed as needed
var target_enemy = null

func _process(delta):
	update_target()

	if target_enemy:
		shoot()

func get_closest_enemy():
	var enemies = get_tree().get_nodes_in_group("enemies")  # Assuming enemies are in a group named "enemies"
	var closest_enemy = null
	var closest_distance = float('inf')

	for enemy in enemies:
		var distance_to_enemy = position.distance_to(enemy.position)
		
		if distance_to_enemy < closest_distance:
			closest_enemy = enemy
			closest_distance = distance_to_enemy

	return closest_enemy



func update_target():
	if not target_enemy:
		target_enemy = get_closest_enemy()

func shoot():
	if Input.is_action_pressed("shoot"):
		var laser_scene = preload("res://Scenes/MainScenes/laser.tscn")
		var laser_instance = laser_scene.instance()
		laser_instance.position = position
		add_child(laser_instance)
		# Add any additional logic for shooting, such as playing a shooting sound, etc.

# Connect to the signal emitted by enemies when they are created
func _ready():
#	connect("enemy_targeted", self, "_on_enemy_targeted")
	pass
	
# Handle the enemy targeted signal
func _on_enemy_targeted(enemy):
	target_enemy = enemy
