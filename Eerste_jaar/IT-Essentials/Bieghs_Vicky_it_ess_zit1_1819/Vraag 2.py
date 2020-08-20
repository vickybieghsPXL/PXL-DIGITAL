#Bieghs Vicky 1TINF

import random


def ascii_waarde_bepalen(lijst_naam, lijst_geboortejaar, uiteindelijke_som, som_lijst):
    waarde_ascii = 0
    for i in lijst_naam:
        for j in i:
            if j in "cinema":
                waarde_ascii = waarde_ascii + (ord(j) * lijst_naam.index(i))
    for i in lijst_geboortejaar:
        uiteindelijke_som = waarde_ascii + lijst_geboortejaar(i)
    som_lijst.append(uiteindelijke_som)

    return som_lijst


def random_getallen():
    prijs = random.randrange(1000, 9999)
    filmtickets = 0
    while prijs [1-9]:
        if prijs < 5000 and prijs % 2 != 1:
            return prijs
        prijs = random.randrange(1000, 9999)
    for i in prijs:
        filmtickets = filmtickets + i
    return filmtickets


naam = str(input("wat is uw naam?: "))
lijst_naam = []
lijst_geboortejaar = []
uiteindelijke_som = 0
som_lijst = []
aantal_bezoeken = 0
versnaperingen = ""
teller = 0
prijs = 0


while naam != "xxx" and "qqq":
    geboortejaar = int(input("geef geboortejaar in: "))
    aantal_bezoeken = str(input("hoe vaak per maand breng je een bezoek aan kinepolis? (1, 2, 3): "))
    versnaperingen = str(input("welke versnaperingen nuttig je? (P, C, N): "))
    lijst_naam.append(naam)
    lijst_geboortejaar.append(geboortejaar)
    naam = str(input("wat is uw naam?: "))
    ascii_waarde_bepalen(lijst_naam, lijst_geboortejaar, uiteindelijke_som, som_lijst)

for i in som_lijst:
    if aantal_bezoeken == 1:
        uiteindelijke_som = uiteindelijke_som / 2
        som_lijst.pop(i)
        som_lijst.insert(teller, uiteindelijke_som)
    elif aantal_bezoeken == 2:
        uiteindelijke_som = uiteindelijke_som * 2
        som_lijst.pop(i)
        som_lijst.insert(teller, uiteindelijke_som)
    elif uiteindelijke_som == 3:
        uiteindelijke_som = uiteindelijke_som * 3
        som_lijst.pop(i)
        som_lijst.insert(teller, uiteindelijke_som)
    if aantal_bezoeken == 1 or 2 and versnaperingen == "N":
        uiteindelijke_som = uiteindelijke_som - 1050
    teller = teller + 1

random_getallen()



