extends Area2D


func _ready():
	pass 

#func _process(delta):
#	pass


func SF_colectado():
	call_deferred("queue_free")
	pass
