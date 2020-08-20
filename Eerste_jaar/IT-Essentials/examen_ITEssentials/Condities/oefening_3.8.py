afstand = int(input("Geef het aantal km in: "))
klasse = int(input("Geef de klasse, 1 = toerist 2 = charter 3 = zakenreis: "))

if afstand < 1000:
    prijs = 0.25 * afstand
elif afstand < 3000:
    prijs = 0.2 * afstand
else:
    prijs = 0.12 * afstand

if klasse == 2:
    prijs *= 0.8
elif klasse == 3:
    prijs *= 1.3

print("De totale prijs is {} EUR".format(round(prijs, 2)))