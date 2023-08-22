extends Node

var _current_scene = "level"
var _current_scene_path = "res://scenes/level.tscn"
var _numero_de_inigos_mortos_na_cena = 2

func _resetGame():
	get_tree().change_scene_to_file(_current_scene_path)

func _gameOver():
	if _current_scene == "level":
		get_tree().get_root().get_node("level")._setMsg("Game Over!")
		
		
func _setMsg(msg: String):
	get_tree().get_root().get_node(_current_scene)._setMsg(msg)
	
func _conta_inigos_mortos():
	_numero_de_inigos_mortos_na_cena = _numero_de_inigos_mortos_na_cena - 1
	if _numero_de_inigos_mortos_na_cena < 0:
		_numero_de_inigos_mortos_na_cena = 0
