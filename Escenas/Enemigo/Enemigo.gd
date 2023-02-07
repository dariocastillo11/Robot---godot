extends Area2D

var posic = Vector2(100,100)
var movimiento = Vector2()
var VELOCIDAD = 200


func _ready():
	OS.center_window()
	set_position(posic)
	
	pass 


func _process(delta):
	SF_animar()
	posic += movimiento * VELOCIDAD * delta
#	posic.x = clamp(posic.x, 50, 430)
#	posic.y = clamp(posic.y, 95, 605)
	
	if (posic.x<=50) or (posic.x>=430):
		movimiento.x=movimiento.x*(-1)
	if (posic.y<=50) or (posic.y>=650):
		movimiento.y=movimiento.y*(-1)
	set_position(posic)
	pass
	
func SF_animar():
	if movimiento.x > 0:
		$AnimatedSprite.set_flip_h(false)
	if movimiento.x < 0:
		$AnimatedSprite.set_flip_h(true)
	pass
func SF_dirigir_enemigo(posic_player):
	#el movimiento sea igual a la posicion del enemigo  -- la posicion del player
	movimiento= posic_player - posic
	movimiento = movimiento.normalized()
	pass
func SF_atrapado():
	# call_deferred("queue_free")
	set_process(false)#esto es otra manera
	pass
