extends PathFollow2D

var speed = 150
var hp = 10

func _physics_process(delta):
	move(delta)
	
func move(delta):
	set_progress(get_progress() + speed * delta)
	

func on_hit(dmg):
	hp -= dmg
	if hp <= 0:
		on_destory()


func on_destory():
	self.queue_free()
