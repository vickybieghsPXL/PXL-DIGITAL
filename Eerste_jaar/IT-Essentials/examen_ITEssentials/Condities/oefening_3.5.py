VAT = 1.21

eenhuidsprijs = 11.5
aantal = int(input("Hoeveel van deze artiekelen wilt u? "))
totaal = (11.5 * aantal) * VAT
if totaal > 1000:
    totaal *= 0.9
    print("KORTINGG")
print("Totale prijs {}".format(round(totaal, 2)))