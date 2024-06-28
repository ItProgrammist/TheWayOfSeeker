extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
var alive = true
var start = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if start == true:
		anim.play("start")
		await anim.animation_finished
		start = false
	
	if alive == true:
		anim.play("default")
	
	if Global.finish_portal == true:
		alive = false
		anim.play("finish")
		await anim.animation_finished
		queue_free()
	
	move_and_slide()
