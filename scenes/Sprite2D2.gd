extends Sprite2D
@onready var group_circle = $"../GroupCircle"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var parentRotation = get_parent().rotation
	print(parentRotation)
	rotation = -parentRotation
