extends Object

class_name Faker

enum Gender {
	Either,
	Male,
	Female,
}

# You can set a different data directory, if the add-on isn't
# in its default expected location
@export var data_dir: String = "res://addons/godot-faker/data"

@export var gender = Gender.Either

@export var locale: String

var _locales: Array[String]

var cache: Dictionary

func _init():
	random_locale()

func get_locales() -> Array[String]:
	if _locales.size() > 0:
		return _locales
	for dir in DirAccess.get_directories_at("res://addons/godot-faker/data"):
		_locales.append(dir)
	return _locales

func random_locale() -> Faker:
	locale = get_locales().pick_random()
	return self
	
func set_locale(to: String) -> Faker:
	assert(get_locales().has(to), "Locale %s does not exist." % [to])
	locale = to
	return self

func male() -> Faker:
	gender = Gender.Male
	return self

func female() -> Faker:
	gender = Gender.Female
	return self

func json(type: String) -> Dictionary:
	# If the JSON has already been loaded, we grab it from the cache.
	if cache.has(locale) and cache[locale].has(type):
		return cache[locale][type]
	
	# Define the path (on form "/da_DK/first_names.json")
	var file: String = data_dir.rstrip("/") + "/%s/%s.json"
	file %= [locale, type]
	
	var data = FileAccess.get_file_as_string(file)
	assert(!!data, "Failed to load mock data from: %s" % [file])
	
	var json = JSON.parse_string(data)
	assert(!!json, "Loaded data from %s, but appears to be invalid JSON." % [file])
	
	if not cache.has(locale):
		cache[locale] = {}
	cache[locale][type] = json
	
	return json
	
func get_gender_key() -> String:
	if gender == Gender.Male:
		return "male"
	elif gender == Gender.Female:
		return "female"
	else:
		return ["male", "female"].pick_random()

func get_commonality_key() -> String:
	var seed: int = randi_range(0, 100)
	if seed < 10:
		return "uncommon"
	elif seed < 35:
		return "common"
	else:
		return "most_common"

func pick_from_json(json: Dictionary) -> String:
	var is_gendered = json.format.gendered
	var gender_key: String
	if is_gendered:
		gender_key = get_gender_key()
	else:
		gender_key = "neutral"
	
	return json[gender_key].pick_random()

func full_name() -> String:
	var json = json("name_templates")
	
	# It's possible that not all commonality exists on a JSON
	# structure, or that it has not content
	var forms: Array
	while not forms:
		var key = get_commonality_key()
		if json.templates.has(key) and json.templates[key].size() > 0:
			forms = json.templates[key]
	
	var form = forms.pick_random()
	var result: String
	var context: String
	
	# Iterate over the selected template (e.g. "[first] [last]") and replace
	# the keys with the appropriate random values.
	for char in form:
		if not context and char == "[":
			context = "["
		elif context and char == "]":
			context = context.substr(1)
			if context == "first":
				result += first_name()
			elif context == "last":
				result += last_name()
			context = ""
		elif context:
			context += char
		else:
			result += char
		
	return result

func first_name() -> String:
	return pick_from_json(json("first_names"))
	
func last_name() -> String:
	return pick_from_json(json("last_names"))
