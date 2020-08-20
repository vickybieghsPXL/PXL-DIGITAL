getal1 = int(input("Geef getal1: "))
getal2 = int(input("Geef getal2: "))

if getal1 < getal2:
    kleinste = getal1
    grootste = getal2
else:
    kleinste = getal2
    grootste = getal1
print("Kleinste: {}".format(kleinste))
print("Kwadraat: {}".format(kleinste ** 2))

if kleinste != 0:
    print("Grootste/kleinste: {}".format(grootste/kleinste))
else:
    print("Kan niet delen door 0")