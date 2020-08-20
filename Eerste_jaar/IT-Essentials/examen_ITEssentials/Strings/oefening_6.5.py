def prijs_per_persoon(aantal_sterren, hotelcode):
    if hotelcode[0:2] == "HI":
        kosten = 70
    elif aantal_sterren > 3:
        kosten = 60
    elif aantal_sterren == 3 and hotelcode[0:2] != "BR" and hotelcode[0:2] != "AN":
        kosten = 60
    elif aantal_sterren == 3:
        kosten = 56
    else:
        kosten = 48
    return kosten


def prijs_per_kind(aantal_sterren, hotelcode, kindercode):
    if kindercode == "A":
        if aantal_sterren < 3:
            return 0
        elif hotelcode != "BR":
            return 0
    return 0.5 * prijs_per_persoon(aantal_sterren, hotelcode)


def sterren_string(aantal_sterren):
    for i in range(aantal_sterren):
        print("*", end="")


aantal_volwassenen = int(input("Geef het aantal volwassenen in: "))
aantal_kinderen = int(input("Geef het aantal kinderen in: "))
hotelcode = input("Geef het hotelcode in: (2 letters gevolgd door 4 cijfers) ")
while hotelcode != "/":
    aantal_sterren = int(input("Hoeveel sterren heeft dit hotel? "))
    kindercode = input("Geef de kindercode: ")
    prijs_kind = prijs_per_kind(aantal_sterren, hotelcode, kindercode)
    prijs_persoon = prijs_per_persoon(aantal_sterren, hotelcode)
    print(hotelcode, end="")
    sterren_string(aantal_sterren)
    print("{} {} {}".format(round(prijs_persoon, 2), round(prijs_kind, 2),
                                     round(aantal_kinderen * prijs_kind + aantal_volwassenen * prijs_persoon, 2)))

    aantal_volwassenen = int(input("Geef het aantal volwassenen in: "))
    aantal_kinderen = int(input("Geef het aantal kinderen in: "))
    hotelcode = input("Geef het hotelcode in: (2 letters gevolgd door 4 cijfers) ")
