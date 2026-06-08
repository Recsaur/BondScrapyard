extends Camera2D
@export var RandStrength: float = 5.0 
@export var ShakeFade: float = 5.0
var OffsetAmt: Vector2 = Vector2(0,0)
var rng = RandomNumberGenerator.new()
var ShakeStrength: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameTracker.connect("Action", ScreenShake)


func _process(delta: float) -> void:
	if ShakeStrength > 0.0:
		ShakeStrength = lerpf(ShakeStrength,0,ShakeFade*delta)
		
		offset = RandOffset()
		
	
func ScreenShake(value: float):
	ShakeStrength = value
	print("screenshakeing?")
	
func RandOffset() -> Vector2:
	#print(ShakeStrength* GameController.Consecutive)
	OffsetAmt = Vector2(rng.randf_range(-ShakeStrength,ShakeStrength),rng.randf_range(-ShakeStrength,ShakeStrength))
	OffsetAmt = OffsetAmt.clamp(Vector2.ZERO,Vector2.ONE*28) #change liek the max max what maximum screenshaking amount
		#print(ShakeStrength* GameController.Consecutive)
	return OffsetAmt
