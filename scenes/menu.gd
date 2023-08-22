extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_new_pressed():
	get_tree().change_scene_to_file("res://scenes/level.tscn") # Replace with function body.


func _on_exit_pressed():
	get_tree().quit() # Replace with function body.


func _on_new_mouse_entered():
	$CenterContainer/VBoxContainer/btFX.play() 


func _on_exit_mouse_entered():
	$CenterContainer/VBoxContainer/btFX.play() 
