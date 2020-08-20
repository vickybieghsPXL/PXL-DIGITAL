from random import randrange


def genereer_random_getallen(random_getallen_lijst, aantal_getallen, veelvoud_getal):
    for i in range(aantal_getallen):
        random_getallen_lijst.append(randrange(0, 100, veelvoud_getal))


aantal_getallen = int(input("Geef het aantal getallen dat random zal berekend worden:\n"))
while aantal_getallen < 1:
    print("Foute invoer! Aantal getallen moet groter zijn dan 1")
    aantal_getallen = int(input("Geef het aantal getallen dat random zal berekend worden:\n"))

veelvoud_getal = int(input("Geef het veelvoud op:\n"))
while veelvoud_getal >= 10:
    print("Foute invoer! Het veelvoud getal moet kleiner zijn dan 10")
    veelvoud_getal = int(input("Geef het veelvoud op:\n"))

random_getallen_lijst = []
genereer_random_getallen(random_getallen_lijst, aantal_getallen, veelvoud_getal)

print("De gegenereerde getallen zijn:")
for i in random_getallen_lijst:
    print(i, end=" ")
print()

if aantal_getallen % 2 != 0:
    print("De array in speciale afdruk:")
    for i in range(len(random_getallen_lijst) - 1, -1, -1):
        print(random_getallen_lijst[i], end=" ")
    print()

gemiddelde = sum(random_getallen_lijst) / len(random_getallen_lijst)

print("De getallen die kleiner zijn dan het gemiddelde:")
for i in random_getallen_lijst:
    if i < gemiddelde:
        print(i, end=" ")
