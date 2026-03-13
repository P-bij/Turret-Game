class_name CalculatePowerups
extends Node


func calculate_powerups(pu_list: Array[PowerUp]) -> Array[PowerUp]:
	var chosen_powerups: Array[PowerUp] = []
	var list: Array[PowerUp] = pu_list.duplicate()
	if list.size() > 3:
		for i in 3:
			var rand_number: int = randi() % list.size()
			chosen_powerups.append(list[rand_number])
			list.remove_at(rand_number)
	else:
		chosen_powerups = list
	return chosen_powerups
