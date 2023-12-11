extends Area2D

@export var speed = -250

#this lets me set the starting pos of the laser,
#which should be at the center of the tower
func start(pos):
	position = pos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += speed * delta 
#change this so that the position chaganges to whichever enemy the tower is aiming at
#and not just go up 


func _on_area_entered(area):
	if area.is_in_group("enemies"):
		area.explode()
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
