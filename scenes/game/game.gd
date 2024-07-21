extends Control

const POSTS_FILE_PATH = "res://assets/posts.json"
const NEWS_FILE_PATH = "res://assets/news.json"

const ENGAGEMENT_NUMBER = 5
const MIN_ENGAGEMENT_THRESHOLD = 20

var posts_json_result
var news_json_result

@onready var button: Button = $VBoxContainer/Button
@onready var button_label: RichTextLabel = $VBoxContainer/Button/ButtonLabel

@onready var button_2: Button = $VBoxContainer/Button2
@onready var button_label_2: RichTextLabel = $VBoxContainer/Button2/ButtonLabel2

@onready var button_3: Button = $VBoxContainer/Button3
@onready var button_label_3: RichTextLabel = $VBoxContainer/Button3/ButtonLabel3

@onready var news_label: RichTextLabel = $VBoxContainer/NewsLabel

@onready var view_number_label: Label = $VBoxContainer/HBoxContainer2/ViewNumberLabel


#group strength
var group1_south_strength = 20
var group2_longhair_strength = 20
var group3_majority_strength = 80
var group4_tea_strength = 20
var group5_notdancing_strength = 20

var profile_engagement = 30

var number_of_news
var current_news_id = 1


func _ready():
	read_social_media_json()
	view_number_label.text = str(profile_engagement)
	
	
func read_social_media_json() -> void:
	read_news_json()
	read_posts_json()
	
	
func read_news_json() -> void:
	if not FileAccess.file_exists(NEWS_FILE_PATH):
		print("File does not exist: %s" % NEWS_FILE_PATH)
		return
	
	# Open the file in read mode
	var file = FileAccess.open(NEWS_FILE_PATH, FileAccess.READ)
	
	if file:
		# Read the entire file as text
		var json_content = file.get_as_text()
		#print(json_content)
		# Close the file
		file.close()

		news_json_result = JSON.parse_string(json_content)
		number_of_news = news_json_result.size()
		print(number_of_news)
		#print("news")
		#print(news_json_result[3])
		set_news_text()
	
	
func read_posts_json() -> void:
	# Check if the file exists
	if not FileAccess.file_exists(POSTS_FILE_PATH):
		print("File does not exist: %s" % POSTS_FILE_PATH)
		return
	
	# Open the file in read mode
	var file = FileAccess.open(POSTS_FILE_PATH, FileAccess.READ)
	
	if file:
		# Read the entire file as text
		var json_content = file.get_as_text()
		#print(json_content)
		# Close the file
		file.close()

		posts_json_result = JSON.parse_string(json_content)
		#print(posts_json_result[0])
		set_button_texts()
		
		
func set_button_texts() -> void:
	var button_number = -1
	for item in posts_json_result:
		if item["news_id"] == current_news_id:
			button_number += 1
			if button_number == 0:
				button_label.text = item["post"]
			if button_number == 1:
				button_label_2.text = item["post"]
			if button_number == 2:
				button_label_3.text = item["post"]
		
	#print("Post " + str(posts_json_result[0]["post"]))

func set_news_text() -> void:
	news_label.text = news_json_result[current_news_id]["newstext"]

func _on_button_pressed() -> void:
	evaluate_post(0)


func _on_button_2_pressed() -> void:
	evaluate_post(1)


func _on_button_3_pressed() -> void:
	evaluate_post(2)

func evaluate_post(number_of_post) -> void:
	print(number_of_post)
	# make groups stronger / weaker
	# TODO times engagement factor
	evaluate_group_strengths(number_of_post)
	evaluate_engagement(number_of_post)
	next_news()
	
func next_news() -> void:
	current_news_id += 1
	if current_news_id < number_of_news:
		set_button_texts()
		set_news_text()
	else:
		finish_game()
	
func finish_game() -> void:
	print("game finished")
	#GameState.group1_south_strength = group1_south_strength
	#GameState.group2_longhair_strength = group2_longhair_strength
	#GameState.group3_majority_strength = group3_majority_strength
	#GameState.group4_tea_strength = group4_tea_strength
	#GameState.group5_notdancing_strength = group5_notdancing_strength
	#GameState.profile_engagement = profile_engagement
	get_tree().change_scene_to_file("res://scenes/finish_screen/finish_screen.tscn")
	
func evaluate_group_strengths(number_of_post) -> void:
	if posts_json_result[number_of_post]["group1_south"]:
		GameState.group1_south_strength += posts_json_result[number_of_post]["group1_south"]
	if posts_json_result[number_of_post]["group2_longhair"]:
		GameState.group2_longhair_strength += posts_json_result[number_of_post]["group2_longhair"]
	if posts_json_result[number_of_post]["group3_majority"]:
		GameState.group3_majority_strength += posts_json_result[number_of_post]["group3_majority"]
	if posts_json_result[number_of_post]["group4_tea"]:
		GameState.group4_tea_strength += posts_json_result[number_of_post]["group4_tea"]
	if posts_json_result[number_of_post]["group5_notdancing"]:
		GameState.group5_notdancing_strength += posts_json_result[number_of_post]["group5_notdancing"]
	print("Group1: " + str(GameState.group1_south_strength))
	print("Group2: " + str(GameState.group2_longhair_strength))
	print("Group3: " + str(GameState.group3_majority_strength))
	print("Group4: " + str(GameState.group4_tea_strength))
	print("Group5: " + str(GameState.group5_notdancing_strength))


func evaluate_engagement(number_of_post) -> void:
	var engagement_change = 0
	if posts_json_result[number_of_post]["engagement"]:
		engagement_change += posts_json_result[number_of_post]["engagement"] 
	if posts_json_result[number_of_post]["group1_south"]:
		engagement_change += posts_json_result[number_of_post]["group1_south"] * group1_south_strength
	if posts_json_result[number_of_post]["group2_longhair"]:
		engagement_change += posts_json_result[number_of_post]["group2_longhair"] * group2_longhair_strength
	if posts_json_result[number_of_post]["group3_majority"]:
		engagement_change += posts_json_result[number_of_post]["group3_majority"] * group3_majority_strength
	if posts_json_result[number_of_post]["group4_tea"]:
		engagement_change += posts_json_result[number_of_post]["group4_tea"] * group4_tea_strength
	if posts_json_result[number_of_post]["group5_notdancing"]:
		engagement_change += posts_json_result[number_of_post]["group5_notdancing"] * group5_notdancing_strength
	if engagement_change < MIN_ENGAGEMENT_THRESHOLD:
		engagement_change = MIN_ENGAGEMENT_THRESHOLD
	GameState.profile_engagement += engagement_change
	view_number_label.text = str(GameState.profile_engagement)
	print("Engagement: " + str(GameState.profile_engagement))
