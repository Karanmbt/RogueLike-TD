extends AnimatedSprite2D


func _ready():
	$AnimationPlayer.play()


func _on_animation_finished():
	queue_free()
