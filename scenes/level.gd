extends Node2D

#$CanvasLayer/CenterContainer/msgGame

func _setMsg(msg:String):
	$CanvasLayer/CenterContainer/msgGame.text =msg

func _ready():
	$music.play()

