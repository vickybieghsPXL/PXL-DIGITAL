gefaalde = 0
geslaagde = 0
naam = input("Geef de naam van de manager: ")
while naam != "xx" and naam != "XX":
    test1 = int(input("Test1: "))
    test2 = int(input("Test2: "))
    test3 = int(input("Test3: "))
    gem = (test3 + test2 + test1) / 3
    if gem < 70:
        resultaat = "faalt"
        gefaalde += 1
    else:
        resultaat = "slaagt"
        geslaagde += 1
    print("{} Test 1: {} ; Test 2 {} ; Test 3 : {} ; Gemiddelde : {} ; Resultaat : {}".format(naam, test1, test2, test3, gem, resultaat))
    naam = input("Geef de naam van de manager: ")
totaal = geslaagde + gefaalde
geslaagde_percentage = (geslaagde / totaal) * 100
print("Er slaagden {}% van de {} deelnemende managers.".format(geslaagde_percentage, totaal))