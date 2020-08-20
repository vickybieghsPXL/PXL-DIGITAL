VAT = 1.21
vaste_kosten = 20
prijs_per_gesprek_binnenland = 0.12
prijs_per_min_buitenland = 0.5

aantal_gesprekken_binnenland = int(input("Hoeveel gesprekken heeft u naar het binnenland gemaakt: "))
aantal_min_buitenland = float(input("Hoeveel minuten heeft u naar het buitenland gepleegt: "))
aantal_min_buitenland = int(aantal_min_buitenland + 0.5)
totaal = VAT * (vaste_kosten + (prijs_per_gesprek_binnenland * aantal_gesprekken_binnenland) + (prijs_per_min_buitenland * aantal_min_buitenland))
print("Je moet {} euro betalen.".format(round(totaal, 2)))