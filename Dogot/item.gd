"""
Класс предмета

Слоты:
	
				 
				head
				shoulders
	left hand	body	right hand
				legs

"""

var characteristic = {} #  в словаре будет характеристика типо макс хп и значение изменения её
var name = null
var description = null
var price = null
var slot = null
var double_hends = null # двуручность т е нельзя во 2-ом слоте руки ничего держать\
var rarity = null #редкость

var dressed = false


func _init(name_):
	if name_ == "sword_is_rusty": #ржавый меч
		name = name_
		description = "An ordinary sword for suckers" # Если что это всё переводчик
		price = 500
		slot = "hand"
		double_hends = false
		characteristic["damage"] = +10
		rarity = "regular"
	if name_ == "tattered_mail": 
		name = name_
		description = "Regular armor for suckers" # Если что это всё переводчик
		price = 500
		slot = "body"
		double_hends = false
		characteristic["armor"] = +5
		characteristic["hp"] = +100
		rarity = "regular"
	if name_ == "speed_boots": 
		name = name_
		description = "Regular armor for suckers" # Если что это всё переводчик
		price = 500
		slot = "legs"
		double_hends = false
		characteristic["speed"] = +1.5
		rarity = "regular"
	

