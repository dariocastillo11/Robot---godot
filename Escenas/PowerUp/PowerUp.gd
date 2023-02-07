extends Area2D
var posic = Vector2()

func _ready():
	OS.center_window()
	SF_inicio()
	randomize()
	pass 
#func _process(delta):


#	pass

func SF_inicio():
	posic= Vector2(-10,-10)
	set_position(posic)
	$Timer.start()
	
	pass


func _on_Timer_timeout():
	#posic= Vector2(((randi()%10)+1)*40, ((randi()%17)+1)*40)
	posic.x =((randi()%10)+1)*40   #es lo mismo que arriba solo que separado
	posic.y=((randi()%17)+1)*40
	set_position(posic)
	
	pass 

	pass 
