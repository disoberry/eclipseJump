extends AudioStreamPlayer2D

const UNTITLED = preload("res://assets/music/unt.mp3")


func _play_music(music: AudioStream, volume = -1.5):
	if stream == music:
		return
		
	stream = music
	set_volume_db(volume)
	play()
	
func play_music_level():
	_play_music(UNTITLED, -1.5)
