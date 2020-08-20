from random import randint

def feedback(juist_getal, gekozen_getal):
    if gekozen_getal == juist_getal:
        return "Correct"
    elif gekozen_getal < juist_getal:
        return "Hoger"
    else:
        return "Lager"


correct = False
teller = 0
getal = randint(1, 10)
while not correct and teller < 4:
    gekozen_getal = int(input("Raad het getal: "))
    if feedback(getal, gekozen_getal) == "Correct":
        correct = True
        print("Correct!")
    elif feedback(getal, gekozen_getal) == "Hoger":
        print("Hoger!")
    else:
        print("Lager!")
    teller += 1