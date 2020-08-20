from random import randint


def gemiddelde(list):
    som = 0
    for i in range(len(list)):
        som += list[i]
    return som / len(list)


aantal_getallen = int(input("Geef het aantal getallen dat random zal berekend worden (meer dan 1): "))
while aantal_getallen < 1:
    aantal_getallen = int(input("Hoger getal dan 1 graag: "))
veelvoud = int(input("Geef het veelvoud (kleiner dan 10): "))
while veelvoud >= 10:
    veelvoud = int(input("Kleiner getal dan 10 graag: "))
list_random_getallen = []
list_kleiner_dan_gem = []
while len(list_random_getallen) < aantal_getallen:
    getal = randint(1, 100)
    if getal % veelvoud == 0:
        list_random_getallen.append(getal)
gem = gemiddelde(list_random_getallen)
print("De gegenereerde getallen zijn:")
for i in range(aantal_getallen):
    print(list_random_getallen[i], end=" ")
    if list_random_getallen[i] < gem:
        list_kleiner_dan_gem.append(list_random_getallen[i])
print()
if aantal_getallen % 2 == 1:
    list_random_getallen.reverse()
print("De gegenereerde getallen in speciale afdruk zijn:")
for i in range(aantal_getallen):
    print(list_random_getallen[i], end=" ")
print()
print("De gegenereerde getallen kleiner dan het gemiddelde:")
for i in range(len(list_kleiner_dan_gem)):
    print(list_kleiner_dan_gem[i], end=" ")
