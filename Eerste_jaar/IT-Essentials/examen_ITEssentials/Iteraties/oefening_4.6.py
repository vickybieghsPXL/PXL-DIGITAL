artikelnr = int(input("Geef het artikelnummer: "))
while artikelnr != 999:
    hoeveelheid = int(input("Geef de hoeveelheid: "))
    eenheidsprijs = int(input("Geef de eenheidsprijs: "))
    print("=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*==*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*==*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*==*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=")
    print("artiekelnummer met {}, {} aantal stuks voor {} euro per stuk. Totaal: {}".format(artikelnr, hoeveelheid, eenheidsprijs, hoeveelheid * eenheidsprijs))
    print("=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*==*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*==*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*==*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=")
    artikelnr = int(input("Geef het artikelnummer: "))