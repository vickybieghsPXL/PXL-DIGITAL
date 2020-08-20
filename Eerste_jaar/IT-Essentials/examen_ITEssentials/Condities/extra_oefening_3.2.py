leeftijd = int(input("Geef je leeftijd: "))
if leeftijd > 17:
    prijs = 25
elif leeftijd > 12:
    prijs = 12.5
else:
    prijs = 6
print("Prijs: {} Leeftijd: {}".format(prijs, leeftijd))
