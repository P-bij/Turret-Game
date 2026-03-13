class_name PowerupSelector
extends PanelContainer

@export var main_powerup_list: Array[PowerUp]

@onready var pu_card_scene: PackedScene = preload("res://UI/powerup_card.tscn")
@onready var game_pauser: PauseControlComponent = $pause_control_component
@onready var caculate_pu: CalculatePowerups = $calculate_powerups
@onready var card_holder: HBoxContainer = %CardHolder

var available_powerup_list: Array[PowerUp]

func _ready() -> void:
	Globals.dropped_powerup.connect(display_powerup_selection)
	Globals.powerup_picked.connect(remove_cards)
	available_powerup_list = main_powerup_list.duplicate()
	game_pauser.pause(false)


func remove_cards(chosen_powerup_type: Globals.PowerupType) -> void:
	for card: Node in card_holder.get_children():
		card.queue_free()
	var code_works: bool = false
	var free_pick: Array[Globals.PowerupType] = [
		Globals.PowerupType.HEAL_OVER_TIME, 
		Globals.PowerupType.INSTANT_HEALTH
		]
	if chosen_powerup_type in free_pick:
		code_works = true
	else:
		for powerup: PowerUp in available_powerup_list:
			if powerup.pu_type == chosen_powerup_type:
				available_powerup_list.erase(powerup)
				code_works = true
				break
	if !code_works:
		printerr("Something went wrong!")
	game_pauser.pause(false)


func display_powerup_selection() -> void:
	game_pauser.pause(true)
	var selected_pu: Array[PowerUp] = (
		caculate_pu.calculate_powerups(available_powerup_list))
	for i in selected_pu.size():
		var powerup_card: PowerupCard = pu_card_scene.instantiate()
		powerup_card.powerup = selected_pu[i]
		card_holder.add_child(powerup_card)
