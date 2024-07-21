extends RigidBody2D

#@export var size: float = 1.0
@onready var shape: CollisionShape2D = $GroupCircle
var originalRadius
var originalpoints
# Called when the node enters the scene tree for the first time.
func _ready():
	if shape:
		var shape = $GroupCircle.shape	#bisschen komisch
		if shape is CircleShape2D:
			originalRadius = shape.radius 
			print("originalradius" + str(originalRadius))
	print("workd")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#verändert die size multiplikativ im format x*1.05
func setSize(newPoints):
	var newSize:float = newPoints / originalpoints
	if $Sprite2D:
		$Sprite2D.scale = Vector2(newSize,newSize);
	if $GroupCircle:
		var shape = $GroupCircle.shape
		if shape is CircleShape2D:
			shape.radius *= newSize;
