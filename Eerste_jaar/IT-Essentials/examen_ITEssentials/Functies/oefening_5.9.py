def hotel_kosten(aantal_nachten):
    aantal_gratis_nachten = aantal_nachten // 3
    return 140.5 * (aantal_nachten - aantal_gratis_nachten)


def vliegtuig_kosten(stad):
    if stad == "Barcelona":
        return 183
    elif stad == "Rome":
        return 220
    elif stad == "Berlijn 125":
        return 125
    elif stad == "Oslo":
        return 450
    return 0


def huurauto_kosten(aantal_dagen):
    kosten = 40 * aantal_dagen
    if aantal_dagen > 7:
        kosten -= 50
    elif aantal_dagen > 3:
        kosten -= 20
    return kosten


def reis_kosten(stad, aantal_dagen):
    return hotel_kosten(aantal_dagen) + vliegtuig_kosten(stad) + huurauto_kosten(aantal_dagen)


aantal_dagen = int(input("Hoeveel dagen wil je op vakantie? "))
stad = input("Welke stad? ")
print("Je kosten zijn {} euro.".format(reis_kosten(stad, aantal_dagen)))