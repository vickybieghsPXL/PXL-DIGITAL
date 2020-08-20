#Bieghs Vicky 1TINF

input_getal = float(input("geef een getal in: "))
getal = input_getal
binair_lijst = []

while getal != 0:
    getal = getal / 2
    if getal % 2 == 0:
        binair_lijst.append(0)
    elif getal % 2 == 1:
        binair_lijst.append(1)

binair_lijst.reverse()
for i in binair_lijst:
    print(i, end="")
