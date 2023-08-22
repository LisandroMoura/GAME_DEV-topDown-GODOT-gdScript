extends Area2D

@export_category("Configurações")
@export var go_to_new_scene:String = "res://scenes/menu.tscn"
#
#@export_flags("Fire", "Water", "Earth", "Wind") var spell_elements = 0
#
#@export_exp_easing("attenuation") var fading_attenuation
#@export_exp_easing("positive_only") var effect_power
#
#
#@export_placeholder("Name in lowercase") var character_id: String
#
#
#@export_group("Racer Properties")
#@export var nickname = "Nick"
#@export var age = 26
#
#@export_subgroup("Car Properties", "car_")
#@export var car_label = "Speedy"
#@export var car_number = 3
#


var player_ref: Player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	if body is Player:
		if Global._numero_de_inigos_mortos_na_cena > 0:
			Global._setMsg("Falta matar alguns Slimes!")
			$RespawMsgGame.start()
			$errorFX.play()
			return
			
		player_ref = body
		Global._setMsg("Missão Completa!")
		player_ref._is_freez = true
		$AudioStreamPlayer2D.play()
		$ChangeToNewScene.start()

func _on_change_to_new_scene_timeout():
	get_tree().change_scene_to_file(go_to_new_scene)
	player_ref._is_freez = false


func _on_respaw_msg_game_timeout():
	Global._setMsg("") 
