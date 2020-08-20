naam = input("Geef de naam van de speler: ")
prijs_vorig_seizoen = int(input("Wat wat de prijs van {} het vorig seizoen? ".format(naam)))
leeftijd = int(input("Wat is de leeftijd van {}? ".format(naam)))
beoordeling = int(input("Wat is de gemiddelde beoordeling van {}, cijfer tussen 0 en 10: ".format(naam)))
type = input("Wat voor speler is {} (aanvaller, middelvelder, verdediger, doelman)? ".format(naam))
aantal_doelpunten = int(input("Hoeveel doelpunten heeft {} gescoord of niet geredt als doelman?".format(naam)))

nieuwe_prijs = prijs_vorig_seizoen  # als basisprijs
if leeftijd < 25:
    nieuwe_prijs * 1.1
elif leeftijd > 30:
    nieuwe_prijs * 0.95

if type == "aanvaller":
    if aantal_doelpunten > 5:
        nieuwe_prijs += 5 * 10000
        nieuwe_prijs += (aantal_doelpunten - 5) * 20000
    else:
        nieuwe_prijs += aantal_doelpunten * 10000
else:
    nieuwe_prijs += 10000 * beoordeling
    if type == "doelman":
        if aantal_doelpunten > 19:
            nieuwe_prijs -= 9000
print("Naam: {}".format(naam))
print("Prijs vorig seizoen: {}".format(prijs_vorig_seizoen))
print("Nieuwe prijs: {}".format(nieuwe_prijs))
