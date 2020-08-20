tshirts = [
    [45, 102, 19, 55, 0],
    [79, 47, 58, 22, 46],
    [109, 33, 112, 0, 0]
]

nog_te_bestellen_small = []
nog_te_bestellen_large = []
nog_te_bestellen_medium = []

def bereken_totaal_aantal(lijst):
    totaal = 0
    for i in range(len(lijst)):
        for j in range(len(lijst[i])):
            totaal += lijst[i][j]
    return totaal

def bereken_totaal_rij(rij, lijst):
    totaal = 0
    for i in range(len(lijst[rij])):
        totaal += lijst[rij][i]
    return totaal

def kleur(index):
    if index == 0:
        return "Rood"
    elif index == 1:
        return "Wit"
    elif index == 2:
        return "Blauw"
    elif index == 3:
        return "Orangje"
    else:
        return "Zwart"

def koop_extra_tshirts(lijst):
    for i in range(len(lijst)):
        for j in range(len(lijst[i])):
            if bereken_totaal_rij(i, tshirts) * 0.3 > tshirts[i][j]:
                if i == 0:
                    nog_te_bestellen_small.append(kleur(j))
                elif i == 1:
                    nog_te_bestellen_medium.append(kleur(j))
                else:
                    nog_te_bestellen_large.append(kleur(j))

koop_extra_tshirts(tshirts)
print("Nog te bestellen small size:", nog_te_bestellen_small)
print("Nog te bestellen medium size:", nog_te_bestellen_medium)
print("Nog te bestellen large size:", nog_te_bestellen_large)
