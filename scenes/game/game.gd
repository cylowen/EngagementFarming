extends Control

const POSTS_FILE_PATH = "res://assets/posts.json"
const NEWS_FILE_PATH = "res://assets/news.json"

const ENGAGEMENT_NUMBER = 5
const MIN_ENGAGEMENT_THRESHOLD = 20

var posts_json_result
var news_json_result

@onready var button: Button = $VBoxContainer/Button
@onready var button_2: Button = $VBoxContainer/Button2
@onready var button_3: Button = $VBoxContainer/Button3
@onready var text_edit: RichTextLabel = $VBoxContainer/TextEdit



#group strength
var group1_south_strength = 20
var group2_longhair_strength = 20
var group3_majority_strength = 80
var group4_tea_strength = 20
var group5_notdancing_strength = 20

var profile_engagement = 30

var number_of_posts


func _ready():
	read_social_media_json()
	
	
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
		print(json_content)
		# Close the file
		file.close()

		news_json_result = JSON.parse_string(json_content)
		print(news_json_result[3])
	
	
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
		print(json_content)
		# Close the file
		file.close()

		posts_json_result = JSON.parse_string(json_content)
		print(posts_json_result[0])
		set_button_texts()
		
		
func set_button_texts() -> void:
	button.text = posts_json_result[0]["post"]
	button_2.text = posts_json_result[1]["post"]
	button_3.text = posts_json_result[2]["post"]



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
	
	
func evaluate_group_strengths(number_of_post) -> void:
	if posts_json_result[number_of_post]["group1_south"]:
		group1_south_strength += posts_json_result[number_of_post]["group1_south"]
	if posts_json_result[number_of_post]["group2_longhair"]:
		group2_longhair_strength += posts_json_result[number_of_post]["group2_longhair"]
	if posts_json_result[number_of_post]["group3_majority"]:
		group3_majority_strength += posts_json_result[number_of_post]["group3_majority"]
	if posts_json_result[number_of_post]["group4_tea"]:
		group4_tea_strength += posts_json_result[number_of_post]["group4_tea"]
	if posts_json_result[number_of_post]["group5_notdancing"]:
		group5_notdancing_strength += posts_json_result[number_of_post]["group5_notdancing"]
	print("Group1: " + str(group1_south_strength))
	print("Group2: " + str(group2_longhair_strength))
	print("Group3: " + str(group3_majority_strength))
	print("Group4: " + str(group4_tea_strength))
	print("Group5: " + str(group5_notdancing_strength))


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
	profile_engagement += engagement_change
	print("Engagement: " + str(profile_engagement))
