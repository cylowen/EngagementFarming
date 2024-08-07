extends RigidBody2D

#@export var size: float = 1.0
@onready var shape: CollisionShape2D = $GroupCircle
var originalRadius
var originalpoints
var sizemult=1.5
# Called when the node enters the scene tree for the first time.
func _ready():
	if shape:
		var shape = $GroupCircle.shape	#bisschen komisch
		if shape is CircleShape2D:
			originalRadius = shape.radius 
			print("originalradius" + str(originalRadius))
	print("workd")


#verändert die size multiplikativ im format x*1.05
func setSize(newRelSize):
	if $Sprite2D:
		$Sprite2D.scale = Vector2(newRelSize,newRelSize);
	if $GroupCircle:
		var shape = $GroupCircle.shape
		if shape is CircleShape2D:
			shape.radius = originalRadius * newRelSize;
	if $Sprite2D2:
		$Sprite2D2.scale = Vector2(newRelSize,newRelSize)

func _input(event):
	if event is InputEventMouseButton:
		setSize(sizemult)
		#sizemult+=0.1
