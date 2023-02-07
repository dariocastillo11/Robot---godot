extends Node2D
#Hecho por Dario c
#destino: Curso videojuegos
#fecha: 

var engranes_inicio = 5
var puntos = 0
var nivel = 0
var posic_engrane = Vector2()
export (PackedScene) var Engrane
var tiempo=10
var posic_player= Vector2()

func _ready():
	OS.center_window()
	randomize()
	SF_instanciar_engranes()
	SF_imprimir()
	$ContenedorAudios/AudioMusica.play()
	pass


#func _process(delta):
#	pass


func SF_instanciar_engranes():
	# Preparo la escena Engrane para salir a jugar
	#var Engranes = Engrane.instance()
	# Donde va a jugar
	#Engranes.set_position(Vector2(100,100))
	# La subo a la cancha o al escenario
	#$ContenedorEngranes.add_child(Engranes)
	
	for cantidad in range(engranes_inicio+ nivel):
		var Engranes = Engrane.instance()
		posic_engrane.x = ((randi()%10)+1)*40
		posic_engrane.y =((randi()%17)+1)*40
		Engranes.set_position(posic_engrane)
		
		#$ContenedorEngranes.add_child(Engranes)
		$ContenedorEngranes.call_deferred("add_child",Engranes)
	
	pass


func _on_Player_colecta():
	puntos += 1
	$ContenedorAudios/AudioEngrane.play()
	SF_detectar_levelup()
	SF_imprimir()
	pass
	SF_imprimir()
pass 
func SF_imprimir():
	$Interfaz/Puntos.set_text(str(puntos))
	$Interfaz/Nivel.set_text(str(nivel))
	$Interfaz/Tiempo.set_text(str(tiempo))
	pass


func _on_TimerMensajes_timeout():
	$Interfaz/Mensaje.set_visible(false)
	pass # Replace with function body.


func _on_TimerPrincipal_timeout():
	tiempo -=1
	SF_detectar_levelup()
	SF_imprimir()
	if tiempo == 0:
		SF_gameover_principal()
		pass
	pass 

func SF_detectar_levelup():
	if $ContenedorEngranes.get_child_count() == 0:
		nivel+=1
		SF_instanciar_engranes()
		SF_mensaje("Level up!!!")
		$ContenedorAudios/AudioLevelUp.play()
		tiempo=10
		$Enemigo.VELOCIDAD+=15
		$Player.VELOCIDAD+=15
		
		pass
func SF_mensaje(mensaje):
	$Interfaz/Mensaje.set_text(mensaje)
	$Interfaz/Mensaje.set_visible(true)
	$Timers/TimerMensajes.start()
	pass


func _on_Button_pressed():
	#Reiniciat todas las variables
	#decirle al persnaje que puede volver a moverse
	#reiniciar los timers
	#etc
	#O podemos recargar toda la escena
	get_tree().reload_current_scene()
	
	pass # Replace with function body.




func _on_Player_atrapado():
	#print("atrapado")
	SF_gameover_principal()
	pass # Replace with function body.
	
	
func SF_gameover_principal():
	#Mostrar mensaje de Game Over.hecho
	SF_mensaje("Perdiste!!!")
	#que deje de pasar el tiempo
	# tiempo=1 #una manera de hacerlo
	$Timers/TimerPrincipal.stop() #otra manera de hacerlo
	#En el player la animacion de daño y que se quede quieto
	$Player.SF_gameover()
	#un sistema para volver a empezar.hechoo
	#creamo un boton start en la interfaz
	#hacer visible el boton
	$Interfaz/Button.set_visible(true)
	#hacer que la puntuacion se agrande
	$Interfaz/Puntos.set_scale(Vector2(2.5,2.5))
	$Timers/TimerEnemigo.stop()
	$Enemigo.SF_atrapado()
	$ContenedorAudios/AudioMusica.stop()
	$ContenedorAudios/AudioGameOver.play()
	pass

func _on_TimerEnemigo_timeout():
	posic_player= $Player.get_position()
	$Enemigo.SF_dirigir_enemigo(posic_player)
	pass # Replace with function body.

func _on_TimerEnemigo2_timeout():
	posic_player= $Player.get_position()
	$Enemigo.SF_dirigir_enemigo(posic_player)
	pass # Replace with function body.


func _on_Player_escudado():
	$ContenedorAudios/AudioPowerUp.play()
	pass 
