class_name AudioManager

extends Node

var sounds = []
var music = []

var spider_attack_sounds = []
var spider_run_sounds = []
var player_run_sounds = []
var player_hit_ground_sounds = []

# TODO: Clean this code section up
func _ready():
	for child_node in get_children():
		var _name = child_node.get_name()
		if _name.find("SpiderAttack") > -1:
			spider_attack_sounds.append(child_node)
		if _name.find("SpiderRun") > -1:
			spider_run_sounds.append(child_node)
		if _name.find("PlayerRun") > -1:
			player_run_sounds.append(child_node)
		if _name.find("PlayerHitGround") > -1:
			player_hit_ground_sounds.append(child_node)
		if _name.find("Music") > -1:
			music.append(child_node)

func play_sound(_name : String):
	for sound_node in sounds:
		if sound_node.get_name() == _name:
			var sound = sound_node
			if sound.is_playing():
				sound.stop()  # Stop the sound if it's already playing
			sound.play()
			return  # Exit the loop once the sound is found and played
	print("Sound: ", _name, " not found in the list of sounds.")

func play_music(_name : String):
	for music_node in music:
		if music_node.get_name() == _name:
			var sound = music_node
			if sound.is_playing():
				sound.stop()  # Stop the music if it's already playing
			sound.play()
			return  # Exit the loop once the sound is found and played
	print("Sound: ", _name, " not found in the list of music.")

# Play random sound from list
func play_random_sound(list):
	for sound in list:
		if sound.playing:
			return 
	list.pick_random().play()
	
# Play random sound from list
func queue_random_sound(list):
	list.pick_random().play()
