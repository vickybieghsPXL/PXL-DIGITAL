def kostprijs(wagen, afstand):
    if wagen == "R":
        kosten = 25
        if afstand > 11:
            if afstand > 21:
                kosten += (21 - 11) * 2.25
                kosten += (afstand - 21) * 1.75
            else:
                kosten += (afstand - 11) * 2.25
        return kosten

    elif wagen == "Z":
        kosten = 20
        if afstand > 11:
            if afstand > 21:
                kosten += (21 - 11) * 2.25
                kosten += (afstand - 21) * 1.75
            else:
                kosten += (afstand - 11) * 2.25
        return kosten


def korting_mutualiteit(wagen, afstand):
    if wagen == "R":
        korting = 15
        if afstand > 11:
            korting += 1.5 * afstand
        return korting

    elif wagen == "Z":
        korting = 10
        if afstand > 11:
            korting += 1 * afstand
        return korting


naam =  input("Geef de naam in: ")
while naam != "/":
    korting = 0
    wagen = input("Welk soort wagen was er nodig? (R = reanimatie, Z = ziekenwagen): ")
    afstand = int(input("Geef de afstand in km: "))
    mutualiteit = input("Wat de persoon lid van een mutualiteit? (J/N): ")
    kostprijs_var = kostprijs(wagen, afstand)
    if mutualiteit == "J":
        korting = korting_mutualiteit(wagen, afstand)
    print("Kostprijs: {}".format(kostprijs(wagen, afstand)))
    print("Korting dat je krijgt: {}".format(korting))
    print("Netto te betalen bedrag: {}".format(kostprijs_var - korting))
    naam = input("Geef de naam in: ")
