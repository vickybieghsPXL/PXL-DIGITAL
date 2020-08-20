getal = int(input("Geef de hoogte: "))
for i in range(getal):
    for j in range(getal, i, -1):
        print("@", end=" ")
    print()