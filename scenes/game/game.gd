extends Control

const POSTS_FILE_PATH = "res://assets/posts.json"
const NEWS_FILE_PATH = "res://assets/news.json"
const MAX_NUMBER_OF_NEWS = 10

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
@onready var node_2d: Node2D = $HBoxContainer/Node2D

@onready var audio_stream_player_2: AudioStreamPlayer = $AudioStreamPlayer2

var number_of_news
var current_news_id = 1

var news_array = []

var rng
var news_counter = 0
var sizemult=1.1

func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	view_number_label.text = str(GameState.profile_engagement)
	read_social_media_json()
	
	
func read_social_media_json() -> void:
	read_news_json()
	read_posts_json()
	next_news()
	
	
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
		for i in range(number_of_news):
			news_array.append(i+1)
		#print("news")
		#print(news_json_result[3])
		#set_news_text()
	
	
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
		#set_button_texts()
		
		
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
	news_label.text = news_json_result[current_news_id-1]["newstext"]

func _on_button_pressed() -> void:
	evaluate_post(0)
	if audio_stream_player_2:
		audio_stream_player_2.play()


func _on_button_2_pressed() -> void:
	evaluate_post(1)
	if audio_stream_player_2:
		audio_stream_player_2.play()


func _on_button_3_pressed() -> void:
	evaluate_post(2)
	if audio_stream_player_2:
		audio_stream_player_2.play()

func evaluate_post(number_of_post) -> void:
	print(number_of_post)
	# TODO times engagement factor
	evaluate_group_strengths(number_of_post)
	evaluate_engagement(number_of_post)
	next_news()
	
func next_news() -> void:
	#current_news_id += 1
	news_counter += 1
	var random_int = rng.randi_range(0, news_array.size()-1)
	current_news_id = news_array[random_int]
	news_array.remove_at(random_int)
	
	if news_counter < MAX_NUMBER_OF_NEWS:
		set_button_texts()
		set_news_text()
	else:
		finish_game()
	
func finish_game() -> void:
	print("game finished")
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
	#Node2D.set_size(sizemult)
	$HBoxContainer/Node2D/Group.setSize(GameState.group1_south_strength / GameState.SOUTH_STRENGTH_START)
	$HBoxContainer/Node2D/Group2.setSize(GameState.group2_longhair_strength / GameState.LONGHAIR_STRENGTH_START)
	$HBoxContainer/Node2D/Group3.setSize(GameState.group3_majority_strength / GameState.MAJORITY_STRENGTH_START)
	$HBoxContainer/Node2D/Group4.setSize(GameState.group4_tea_strength / GameState.TEA_STRENGTH_START)
	$HBoxContainer/Node2D/Group5.setSize(GameState.group5_notdancing_strength / GameState.NOTDANCING_START)
	#sizemult+=0.05


func evaluate_engagement(number_of_post) -> void:
	var engagement_change = 0
	if posts_json_result[number_of_post]["engagement"]:
		engagement_change += posts_json_result[number_of_post]["engagement"] 
	if posts_json_result[number_of_post]["group1_south"]:
		engagement_change += posts_json_result[number_of_post]["group1_south"] * GameState.group1_south_strength
	if posts_json_result[number_of_post]["group2_longhair"]:
		engagement_change += posts_json_result[number_of_post]["group2_longhair"] * GameState.group2_longhair_strength
	if posts_json_result[number_of_post]["group3_majority"]:
		engagement_change += posts_json_result[number_of_post]["group3_majority"] * GameState.group3_majority_strength
	if posts_json_result[number_of_post]["group4_tea"]:
		engagement_change += posts_json_result[number_of_post]["group4_tea"] * GameState.group4_tea_strength
	if posts_json_result[number_of_post]["group5_notdancing"]:
		engagement_change += posts_json_result[number_of_post]["group5_notdancing"] * GameState.group5_notdancing_strength
	if engagement_change < MIN_ENGAGEMENT_THRESHOLD:
		engagement_change = MIN_ENGAGEMENT_THRESHOLD
	if posts_json_result[number_of_post]["rage"]:
		GameState.rage_level += posts_json_result[number_of_post]["rage"]
	GameState.profile_engagement += engagement_change
	view_number_label.text = str(GameState.profile_engagement)
	print("Engagement: " + str(GameState.profile_engagement))
