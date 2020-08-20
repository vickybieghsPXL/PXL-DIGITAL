def bereken_kinder_bijslag(aantal_kinderen, leeftijd, code, stekind):
    if stekind == 0:
        bijslag = 75
    else:
        bijslag = 75 * stekind
    if code == "H":
        bijslag = 300
    if leeftijd >= 6:
        bijslag += 25
        if leeftijd >= 12:
            bijslag += 25
    return bijslag

totaal_bijslag = 0
aantal_kinderen = int(input("Geef het aantal kinderen in: "))
for i in range(aantal_kinderen):
    leeftijd = int(input("Geef de leeftijd in: "))
    code = input("Geef de code in: (H = handicap, anders gewoon een spatie) ")
    totaal_bijslag += bereken_kinder_bijslag(aantal_kinderen, leeftijd, code, i)
print("Totale bijslag: {}".format(totaal_bijslag))