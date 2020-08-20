som = 0
aantal_negatieve_getallen = 0

getal = int(input("Geef een getal: "))
while getal != 0:
    som += getal
    if getal < 0:
        aantal_negatieve_getallen += 1
    getal = int(input("Geef een getal: "))

print("Som: {}; aantal negatieve getallen: {}".format(som, aantal_negatieve_getallen))
