totale_premie = 0
hoogste_premie = 0
familienaam = input("Geef de familienaam: ")
while familienaam != "/" and familienaam != "*":
    voornaam = input("Geef de voornaam: ")
    aantal_dienstjaren = int(input("Geef het aantal dienstjaren: "))
    while aantal_dienstjaren < 0 or aantal_dienstjaren > 40:
        aantal_dienstjaren = int(input("Geef het aantal dienstjaren: "))
    if aantal_dienstjaren > 5:
        premie = 25 * aantal_dienstjaren
        totale_premie += premie
        if premie > hoogste_premie:
            hoogste_premie = premie
    print("{} {} heeft {} euro gekregen.".format(voornaam, familienaam, premie))
    familienaam = input("Geef de familienaam: ")
print("Totale premie: {}; Hoogste premie: {}".format(totale_premie, hoogste_premie))