from random import randint

def perfect_getal(getal):
    som = 0
    for i in range(1, getal):
        if getal % i == 0:
            som += i
    if som == getal:
        return True
    return False

def genereer_random_nummer_elk_cijfer_met_grenzen(ondergrens, bovengren, aantal_cijfers):
    getal = 0
    for i in range(aantal_cijfers):
        getal += randint(ondergrens, bovengren) * (10 ** i)
    return getal

for i in range(50):
    getal = randint(1, 100)
    if perfect_getal(getal):
        print("{} is een perfect getal".format(getal))
    else:
        print("{} is geen perfect getal".format(getal))

for j in range(50):
    getal = genereer_random_nummer_elk_cijfer_met_grenzen(1, 3, 4)
    if perfect_getal(getal):
        print("{} is een perfect getal".format(getal))
    else:
        print("{} is geen perfect getal".format(getal))