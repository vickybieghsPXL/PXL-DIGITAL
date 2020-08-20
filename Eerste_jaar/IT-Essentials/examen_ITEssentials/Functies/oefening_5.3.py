def bereken_lidgeld(leeftijd, aantal_kinderen_ten_laste, inkomen, aansluitingsjaar0):
    lidgeld = 100
    if leeftijd > 60:
        lidgeld -= 60
    if aantal_kinderen_ten_laste > 0:
        korting = 7.5 * aantal_kinderen_ten_laste
        if korting > 35:
            korting = 35
        lidgeld -= korting
    if 2018 - aansluitingsjaar > 20:
        lidgeld -= 12.5
    if inkomen < 7500:
        lidgeld -= 25
    if lidgeld < 50:
        lidgeld = 50
    return lidgeld

naam = input("Geef een naam: ")
while naam != "xx" and naam != "XX":
    leeftijd = int(input("Wat is de leeftijd? "))
    aantal_ten_laste = int(input("Hoeveel kinderen heeft hij/zij ten laste? "))
    inkomen = int(input("Wat is zijn/haar inkomen? "))
    aansluitingsjaar = int(input("Wat is zijn/haar aansluitingsjaar? "))
    print("--**--**--**--**--**--**--**--**--**--**--")
    print("Naam: {}".format(naam))
    print("Lidgeld: {}".format(bereken_lidgeld(leeftijd, aantal_ten_laste, inkomen, aansluitingsjaar)))
    print("--**--**--**--**--**--**--**--**--**--**--")