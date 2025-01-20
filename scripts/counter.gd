extends HBoxContainer

@export var zero : Resource
@export var one : Resource
@export var two : Resource
@export var three : Resource
@export var four : Resource
@export var five : Resource
@export var six : Resource
@export var seven : Resource
@export var eight : Resource
@export var nine : Resource

func update_counter(counter: int) -> void:
	var onesDigit = counter % 10
	var tensDigit = (counter / 10) % 10
	var hundredsDigit = (counter / 100) % 10
	
	# Ones Digit
	set_texture($One, onesDigit)
	
	# Tens Digit
	if tensDigit > 0:
		set_texture($Ten, tensDigit)
	else:
		$Ten.texture = null
		
	# Hundreds Digit
	if hundredsDigit > 0:
		set_texture($Hundred, hundredsDigit)
	else:
		$Hundred.texture = null

func set_texture(node: Node, digit: int) -> void:
	match digit:
		0:
			node.texture = zero
		1:
			node.texture = one
		2:
			node.texture = two
		3:
			node.texture = three
		4:
			node.texture = four
		5:
			node.texture = five
		6:
			node.texture = six
		7:
			node.texture = seven
		8:
			node.texture = eight
		9:
			node.texture = nine
