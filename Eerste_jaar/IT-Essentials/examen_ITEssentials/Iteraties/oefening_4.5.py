getal = int(input("Geef een getal tussen 1 en 100: "))
while getal < 0 or getal > 100:
    getal = int(input("Fout, geef een getal tussen 1 en 100: "))
print(getal)