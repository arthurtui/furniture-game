extends Resource
class_name Beatmap

export(String) var song_name
export(String, FILE, "*.ogg") var song_path
export(float) var bpm
export(int) var duration_beats
export(Dictionary) var beats : Dictionary
