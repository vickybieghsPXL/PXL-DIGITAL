from datetime import datetime

basisbedrag = 100
leeftijds_korting = 14.5
aangesloten_jaren_korting = 2.5
minimum = 62.5

leeftijd = int(input("Geef je leeftijd in: "))
aangesloten_jaar = int(input("Geef je aangesloten jaar in: "))

prijs = basisbedrag
if leeftijd < 21 or leeftijd > 60:
    prijs -= leeftijds_korting

prijs -= (aangesloten_jaren_korting * (datetime.now().year - aangesloten_jaar))
if prijs < 62.5:
    prijs = 62.5
print("prijs:", prijs)