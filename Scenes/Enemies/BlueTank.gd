extends PathFollow2D

signal base_damage(damage)


var speed = 150
var hp = 10
var base_dmg = 21

@onready var health_bar = get_node('HeathBar')
#@onready var impact_area = get_node('Impact')
#var hitscan_impact = preload("res://Scenes/SupportScenes/hitscan_impact.tscn")



func _ready():
	health_bar.max_value = hp
	health_bar.value = hp
	health_bar.set_as_top_level(true)

func _physics_process(delta):
	if progress_ratio == 1.0:
		emit_signal("base_damage", base_dmg)
		queue_free()
	move(delta)
	
func move(delta):
	set_progress(get_progress() + speed * delta)
	health_bar.set_position(position - Vector2(30,32))

func on_hit(dmg):
	#impact()
	hp -= dmg
	health_bar.value = hp
	if hp <= 0:
		on_destory()
"""
func impact():
	randomize()
	var x_pos = randi() % 31
	randomize()
	var y_pos = randi() % 31
	var impact_location = Vector2(x_pos, y_pos)
	var new_impact = hitscan_impact.instantiate()
	new_impact.position = impact_location
	impact_area.add_child(new_impact)
"""

func on_destory():
	self.queue_free()
