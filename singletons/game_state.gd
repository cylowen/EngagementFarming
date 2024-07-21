extends Node


const SOUTH_STRENGTH_START = 20
const LONGHAIR_STRENGTH_START = 20
const MAJORITY_STRENGTH_START = 80
const TEA_STRENGTH_START = 20
const NOTDANCING_START = 20
const PROFILE_ENGAGEMENT_START = 30

var group1_south_strength = 0
var group2_longhair_strength = 0
var group3_majority_strength = 0
var group4_tea_strength = 0
var group5_notdancing_strength = 0

var profile_engagement = 0


func _ready() -> void:
	group1_south_strength = SOUTH_STRENGTH_START
	group2_longhair_strength = LONGHAIR_STRENGTH_START
	group3_majority_strength = MAJORITY_STRENGTH_START
	group4_tea_strength = TEA_STRENGTH_START
	group5_notdancing_strength =NOTDANCING_START
	profile_engagement = PROFILE_ENGAGEMENT_START
