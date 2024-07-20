extends Control

const FILE_PATH = "res://assets/firstprototype.json"

var json_result



func _ready():
	read_social_media_json()
		
		
		
func read_social_media_json() -> void:
	# Check if the file exists
	if not FileAccess.file_exists(FILE_PATH):
		print("File does not exist: %s" % FILE_PATH)
		return
	
	# Open the file in read mode
	var file = FileAccess.open(FILE_PATH, FileAccess.READ)
	
	if file:
		# Read the entire file as text
		var json_content = file.get_as_text()
		print(json_content)
		# Close the file
		file.close()

		json_result = JSON.parse_string(json_content)
		print(json_result[0])




