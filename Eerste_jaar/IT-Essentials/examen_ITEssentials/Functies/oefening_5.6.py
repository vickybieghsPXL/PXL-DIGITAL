from random import randint

def genereer_huiswerk(reeks):
    print("Reeks {}".format(reeks))
    for i in range(5):
        getal1 = randint(0, 20)
        getal2 = randint(0, 20)
        while getal1 - getal2 < 0:
            getal1 = randint(0, 20)
            getal2 = randint(0, 20)
        print("{}) {:2} - {:2} = ".format(i + 1, getal1, getal2))

for i in range(5):
    genereer_huiswerk(i + 1)