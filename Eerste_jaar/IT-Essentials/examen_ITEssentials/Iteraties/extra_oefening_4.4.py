aantal_slechte_conditie = 0
geslacht = int(input("Geef het geslacht (1=M, 2=V): "))
while geslacht == 1 or geslacht == 2:
    afstand = float(input("Geef de afstand in km na 12 min lopen: ")) * 1000
    conditie_getal = ((afstand - 504.9) / 44.73)
    if geslacht == 1 and conditie_getal < 36:
        aantal_slechte_conditie += 1
    elif geslacht == 2 and conditie_getal < 29:
        aantal_slechte_conditie += 1
    geslacht = int(input("Geef het geslacht (1=M, 2=V): "))
print("Aantal personen in slechte conditie: {}".format(aantal_slechte_conditie))
