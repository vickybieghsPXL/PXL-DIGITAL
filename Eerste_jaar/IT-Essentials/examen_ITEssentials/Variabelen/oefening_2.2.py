aantal_volwassenen = int(input("Hoeveel volwassenen zijn er? "))
aantal_kinderen = int(input("Hoeveel kinderen zijn er? "))

totaal = aantal_kinderen * 6
totaal += aantal_volwassenen * 11

print("Totaal: {} euro".format(totaal))