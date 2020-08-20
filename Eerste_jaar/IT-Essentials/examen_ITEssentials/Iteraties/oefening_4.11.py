counter1 = 0
counter2 = 0
personeelsnr = int(input("Geef het personeelsnummer: "))
while personeelsnr != 0:
    geslacht = int(input("Geef het geslacht (0=V, 1=M): "))
    while geslacht != 0 and geslacht != 1:
        geslacht = int(input("Geef het geslacht (0=V, 1=M): "))
    leeftijd = int(input("Geef de leeftijd: "))
    bruto = int(input("Geef het brutoloon: "))
    if geslacht == 1 or bruto >= 1800 or leeftijd > 34:
        counter1 += 1
    if geslacht == 0 and leeftijd < 25:
        counter2 += 1
    personeelsnr = int(input("Geef het personeelsnummer: "))
print("Aantal mannelijke personen of personen ouder dan 34 of een loon >1800 euro: {}".format(counter1))
print("Aantal vrouwlijke personen jonger dan 25: {}".format(counter2))