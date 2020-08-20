vast_bedrag = 25
verbruik = float(input("Geef het verbruik in m³: "))
prijs = vast_bedrag
if verbruik > 30 and verbruik <= 200:
    prijs += verbruik * 1
elif verbruik > 200 and verbruik <= 5000:
    prijs += verbruik * 1.15
elif verbruik > 5000:
    prijs += verbruik * 1.175

print(prijs)