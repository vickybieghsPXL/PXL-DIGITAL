lengte = float(input("Geef de lengte: "))
breedte = float(input("Geef de breedte: "))
prijs_per_vierkante_meter = float(input("Geef de prijs per vierkante meter: "))
plaatsings_kosten_per_vierkante_meter = float(input("Geef de plaatsingskosten per vierkante meter: "))

aantal_vierkante_meter = lengte * breedte
prijs_tapijt = aantal_vierkante_meter * prijs_per_vierkante_meter
plaatsings_kosten = aantal_vierkante_meter * plaatsings_kosten_per_vierkante_meter
totaal = prijs_tapijt + plaatsings_kosten

print("De kostprijs van het tapijt is {} EUR".format(prijs_tapijt))
print("De plaatsingskost bedraagt {} EUR".format(plaatsings_kosten))
print("De totale prijs is {}".format(totaal))