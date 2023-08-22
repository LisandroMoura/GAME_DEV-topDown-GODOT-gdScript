extends CanvasLayer

@export var msg:String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/VBoxContainer/Label.text = msg
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
