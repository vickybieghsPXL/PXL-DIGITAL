import random


def main():
    aantal_getallen = int(input("Geef het aantal getallen dat random zal berekend worden \n"))
    while (aantal_getallen < 1):
        veelvoud_getal = int(input("getal moet groter dan 1 zijn: \n"))

    veelvoud_getal = int(input("geef het veelvoud op: \n"))

    while (veelvoud_getal >= 10):
        veelvoud_getal = int(input("getal moet kleiner dan 10 zijn \n"))

    random_getallen_lijst = []
    genereer_random_getallen(random_getallen_lijst, aantal_getallen, veelvoud_getal)

    print("de gegenereerde getallen zijn:")
    for i in random_getallen_lijst:
        print(i, end=" ")
    print()

    if (aantal_getallen % 2 != 0):
        print("de array in speciale afdruk:")
        random_getallen_lijst.reverse()
        for i in random_getallen_lijst:
            print(i, end=" ")
    print()
    print("de getallen die kleiner zijn dan het gemiddelde:")

    gemiddelde = sum(random_getallen_lijst) / len(random_getallen_lijst)
    for i in random_getallen_lijst:
        if(i < gemiddelde):
            print(i, end=  " ")


def genereer_random_getallen(lijst, aantal, veelvoud):
    for i in range(0, aantal):
        random_veelvoud = random.randint(0, 100) * veelvoud
        while (random_veelvoud > 101):
            random_veelvoud = random.randint(0, 100) * veelvoud
        lijst.insert(i, random_veelvoud)


if __name__ == '__main__':
    main()
