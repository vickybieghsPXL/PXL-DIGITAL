aantal_sterren = int(input("Geef de aantal sterren: "))
code = input("Geef de code: (O, H, V of A) ")
aantal_overnachtingen = int(input("Geef je aantal nachten dat je wil overnachten: "))
seizoen = input("Geef je seizoen in: (H, L of T) ")

if aantal_sterren < 2:
    prijs = 30 * aantal_overnachtingen
elif aantal_sterren < 4:
    prijs = 40 * aantal_overnachtingen
else:
    prijs = 55 * aantal_overnachtingen

if code == "O":
    prijs *= 0.2
elif code == "H":
    prijs *= 0.5
elif code == "V":
    prijs *= 0.6
else:
    prijs *= 0.6
    prijs += 80 * aantal_overnachtingen

if seizoen == "H" or code == "O":
    prijs *= 0.9

print(prijs)