extends Node

var bodies = {
	0: "Human", 1: "Elf", 2: "Orc", 3: "Goblin",
	4: "Demon"
	}

var hairstyles = {
	0: "None", 1: "Buzz", 2: "Bouncy", 3: "Posh", 4: "Good Boy",
	5: "Scholar", 6: "Pompadour", 7: "Mullet"
	}

var hair_colors = {
	0: "Sienna", 1: "Ruby", 2: "Sapphire", 3: "Emerald",
	4: "Pink Quartz", 5: "Ash"
	}

var hats = {0: "None", 1: "Witch's Hat", 2: "Leperchaun's Hat", 3: "Beach Hat",
	4: "Pirate Hat", 5: "Propeller Hat", 6: "Cowboy Hat"
	}

var armors = {0: "None", 1: "Pink Robe"
	}

func get_haircolor_file(col):
	col = hair_colors[col]
	col = col.to_lower()
	return ("res://assets/sprites/palettes/"+col+".png")

func get_hairstyle_frame(fr):
	return hairstyles[fr]
