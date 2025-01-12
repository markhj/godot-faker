extends Control

@onready var label_male_name: Label = $MarginContainer/VBoxContainer/HBox_MaleName/LabelValue
@onready var label_female_name: Label = $MarginContainer/VBoxContainer/HBox_FemaleName/LabelValue
@onready var locale_list: ItemList = $MarginContainer/VBoxContainer/HBox_Options/LocalesList

var faker: Faker = Faker.new()

var locales: Array[String]

func _ready():
	refresh()
	
	locales = faker.get_locales()
	
	for locale in locales:
		locale_list.add_item(locale)
	
	locale_list.select(locales.find(faker.locale))

func _on_button_generate_pressed():
	refresh()

func _on_locales_list_item_selected(index):
	faker.locale = locales[index]
	
func refresh() -> void:
	label_male_name.text = faker.male().full_name()
	label_female_name.text = faker.female().full_name()
