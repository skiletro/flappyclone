extends HBoxContainer

@export var empty : Resource
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
	
	match onesDigit:
		0:
			$One.texture = zero
		1:
			$One.texture = one
		2:
			$One.texture = two
		3:
			$One.texture = three
		4:
			$One.texture = four
		5:
			$One.texture = five
		6:
			$One.texture = six
		7:
			$One.texture = seven
		8:
			$One.texture = eight
		9:
			$One.texture = nine
			
	if tensDigit > 0:
		match tensDigit:
			0:
				$Ten.texture = zero
			1:
				$Ten.texture = one
			2:
				$Ten.texture = two
			3:
				$Ten.texture = three
			4:
				$Ten.texture = four
			5:
				$Ten.texture = five
			6:
				$Ten.texture = six
			7:
				$Ten.texture = seven
			8:
				$Ten.texture = eight
			9:
				$Ten.texture = nine

			
	if hundredsDigit > 0:
		match hundredsDigit:
			0:
				$Hundred.texture = zero
			1:
				$Hundred.texture = one
			2:
				$Hundred.texture = two
			3:
				$Hundred.texture = three
			4:
				$Hundred.texture = four
			5:
				$Hundred.texture = five
			6:
				$Hundred.texture = six
			7:
				$Hundred.texture = seven
			8:
				$Hundred.texture = eight
			9:
				$Hundred.texture = nine
