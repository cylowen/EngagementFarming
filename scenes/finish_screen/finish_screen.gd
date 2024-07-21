extends Control


@onready var rich_text_label: RichTextLabel = $VBoxContainer/RichTextLabel2
@onready var engagement_eval_label: RichTextLabel = $VBoxContainer/EngagementEvalLabel



const GROUP_STRENGTH_TEXT5 = "Du hattest keinen Einfluss auf die "


func _ready() -> void:
	
	if GameState.profile_engagement < 4000:
		engagement_eval_label.text += "Du hast nur wenige Views erzielen können. "
	elif 4000 < GameState.profile_engagement && GameState.profile_engagement < 8000:
		engagement_eval_label.text += "Du hast ein mittleres Level an Views erzielen können. "
	else:
		engagement_eval_label.text += "Du hast ein hohes Level an Views erzielen können. "
	
	if GameState.rage_level < -5:
		engagement_eval_label.text += "Du hast mit deinen Posts die Welt ein bisschen weniger wütend gemacht."
	elif -5 < GameState.rage_level && GameState.rage_level < 5:
		engagement_eval_label.text += "Du hast kaum Hass verbreitet."
	else:
		engagement_eval_label.text += "Du hast es in Kauf genommen, Diskriminierungen zu reproduzieren und Hass zu verbreiten."
	
	
	#Süden
	if GameState.group1_south_strength < GameState.SOUTH_STRENGTH_START:
		rich_text_label.text += "Du hast die Community des Südens um " + str(GameState.SOUTH_STRENGTH_START-GameState.group1_south_strength) + " Punkte geschwächt."
	elif GameState.group1_south_strength > GameState.SOUTH_STRENGTH_START:
		rich_text_label.text += "Du hast die Community des Südens um " + str(GameState.group1_south_strength - GameState.SOUTH_STRENGTH_START) + " Punkte gestärkt. "
	else:
		rich_text_label.text += GROUP_STRENGTH_TEXT5 + "Community des Südens. "
		
		
	#Langhaar
	if GameState.group2_longhair_strength < GameState.LONGHAIR_STRENGTH_START:
		rich_text_label.text += "Du hast die Community der lamghaarigen Menschen um " + str(GameState.LONGHAIR_STRENGTH_START-GameState.group2_longhair_strength) + " Punkte geschwächt. "
	elif GameState.group2_longhair_strength > GameState.LONGHAIR_STRENGTH_START:
		rich_text_label.text += "Du hast die Community der lamghaarigen Menschen um " + str(GameState.group2_longhair_strength - GameState.LONGHAIR_STRENGTH_START) + " Punkte gestärkt. "
	else:
		rich_text_label.text += GROUP_STRENGTH_TEXT5 + "Community der langhaarigen Menschen. "
	
	#Majority
	if GameState.group3_majority_strength < GameState.MAJORITY_STRENGTH_START:
		rich_text_label.text += "Du hast die Mehrheit um " + str(GameState.MAJORITY_STRENGTH_START-GameState.group3_majority_strength) + " Punkte geschwächt. "
	elif GameState.group3_majority_strength > GameState.MAJORITY_STRENGTH_START:
		rich_text_label.text += "Du hast die Mehrheit um " + str(GameState.group3_majority_strength - GameState.MAJORITY_STRENGTH_START) + " Punkte gestärkt. "
	else:
		rich_text_label.text += GROUP_STRENGTH_TEXT5 + "Mehrheit. "
		
	#Tee
	if GameState.group4_tea_strength < GameState.TEA_STRENGTH_START:
		rich_text_label.text += "Du hast die Community der Teetrinkenden um " + str(GameState.TEA_STRENGTH_START-GameState.group4_tea_strength) + " Punkte geschwächt. "
	elif GameState.group3_majority_strength > GameState.MAJORITY_STRENGTH_START:
		rich_text_label.text += "Du hast die Community der Teetrinkenden um " + str(GameState.group4_tea_strength - GameState.TEA_STRENGTH_START) + " Punkte gestärkt. "
	else:
		rich_text_label.text += GROUP_STRENGTH_TEXT5 + "Community der Teetrinkenden. "
		
	#Nodancers
	if GameState.group5_notdancing_strength < GameState.NOTDANCING_START:
		rich_text_label.text += "Du hast die Community der Nichttänzer*innen um " + str(GameState.NOTDANCING_START-GameState.group5_notdancing_strength) + " Punkte geschwächt. "
	elif GameState.group3_majority_strength > GameState.MAJORITY_STRENGTH_START:
		rich_text_label.text += "Du hast die Community der Nichttänzer*innen um " + str(GameState.group5_notdancing_strength - GameState.NOTDANCING_START) + " Punkte gestärkt. "
	else:
		rich_text_label.text += GROUP_STRENGTH_TEXT5 + "Community der Nichttänzer*innen. "

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_screen/start_screen.tscn")
