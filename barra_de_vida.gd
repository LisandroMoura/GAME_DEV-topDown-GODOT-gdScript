extends ProgressBar
var sb = StyleBoxFlat.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color("81ff18")
	self.visible = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self.value < 40:
		sb.bg_color = Color("ff0000")
		return 
	
	if self.value < 70:
		sb.bg_color = Color("ffff00")
	else:
		sb.bg_color = Color("81ff18")
	
##

