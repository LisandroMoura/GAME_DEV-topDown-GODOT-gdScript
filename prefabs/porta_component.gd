extends Area2D

class_name  PortaComponent


@export_category("Setups")
@export var teleport: Vector2 =  Vector2(1300,254)
@export var ref_posicao_na_scene_atual:String = "level"
@export var label:String = "Exit"
var ref_player_detect: Player


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Label.text = label

func _on_body_entered(body):
		if body is Player:
			ref_player_detect = body
			$AnimationPlayer.play("open")

func _on_body_exited(body):
	if body is Player:
		$AnimationPlayer.play("RESET")

func teleport_to() -> void:
	ref_player_detect.global_position = teleport
	if ref_posicao_na_scene_atual == "CasaInterna":
		ref_player_detect.camera_2d.limit_left   = 1130
		ref_player_detect.camera_2d.limit_top    = 33
		ref_player_detect.camera_2d.limit_right  = 1467
		ref_player_detect.camera_2d.limit_bottom = 390
	if ref_posicao_na_scene_atual == "level":
		ref_player_detect.camera_2d.limit_left   = -90
		ref_player_detect.camera_2d.limit_top    = -172
		ref_player_detect.camera_2d.limit_right  = 950  
		ref_player_detect.camera_2d.limit_bottom = 453


func _on_animation_player_animation_finished(_anim_name):
	teleport_to()
