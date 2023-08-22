extends Area2D

@export var qtde_vida_recuperada:float = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _coletado():
	$AudioStreamPlayer2D.play()
	$waitColeta.start()
  
func _on_body_entered(_body):
	if _body is Player:
		var vida = _body._setItemColetado(qtde_vida_recuperada)
		if vida < 100:
			_coletado()


func _on_wait_coleta_timeout():
	queue_free()
