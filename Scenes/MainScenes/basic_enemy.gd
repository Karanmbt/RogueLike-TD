extends CharacterBody2D

var target_position = Vector2()  # Center of the screen
var speed = 1

func get_distance_to_screen_edge():
	var screen_size = get_viewport_rect().size
	var center = screen_size / 2
	var point_on_edge = Vector2(screen_size.x, screen_size.y) / 2  # Assuming the bottom-right corner

	var distance = center.distance_to(point_on_edge)
	return distance
	
var spawn_distance = get_distance_to_screen_edge()

func _ready():
	# Spawn enemies outside the screen
	var spawn_direction = Vector2(randf_range(0, 360), 1).normalized()
	position = target_position + spawn_direction * spawn_distance

func _physics_process(delta):
	move(delta)

func move(delta):
	# Move towards the center of the screen
	var direction = (target_position - position).normalized()
	move_and_collide(direction*speed)

func _on_TowerCollision_area_entered(area):
	# Check if the colliding area is the tower's CollisionShape2D
	if area.is_in_group("tower_collision_area"):
		# Deal damage to the tower
		area.get_node("/root/Tower").take_damage(0.1)  # Set damage value here
