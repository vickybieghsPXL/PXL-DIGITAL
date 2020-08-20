from random import randint


def zetOmNaarRomeinsCijfer(roman, waarde, getal):
    roman_string = ""
    hoeveelheden = []
    for i in range(len(roman)):
        hoeveel_keer = getal // waarde[i]
        hoeveelheden.append(hoeveel_keer)
        getal %= waarde[i]

    for i in range(len(hoeveelheden)):
        roman_string += roman[i] * hoeveelheden[i]

    return roman_string


roman = ["XL", "X", "IX", "V", "IV", "I"]
waarde = [40, 10, 9, 5, 4, 1]
gegenereerde_getallen = []

letter = input("Geef letter: ")
print()
aantal_reeksen = ord(letter) - 96

for i in range(aantal_reeksen):
    rij = []
    print("Reeks", chr(i + 97))
    getal = randint(1, 50)
    vorig_getal = getal - 1
    while getal > vorig_getal:
        rij.append(getal)
        print("Het Romeinse cijfer voor", getal, "is", zetOmNaarRomeinsCijfer(roman, waarde, getal))
        vorig_getal = getal
        getal = randint(1, 50)
    print()
    gegenereerde_getallen.append(rij)
print()

# index 0 = minder dan 50
# index 1 = tussen 50 en 70
# index 2 = tussen 70 en 90
# index 3 = meer dan 90
sommen = [0, 0, 0, 0]

for rij in gegenereerde_getallen:
    if sum(rij) < 50:
        sommen[0] += 1
    elif 50 <= sum(rij) and sum(rij) < 70:
        sommen[1] += 1
    elif 70 <= sum(rij) and sum(rij) < 90:
        sommen[2] += 1
    else:
        sommen[3] += 1

print("Aantal reeksen met een som van gegenereerde getallen minder dan 50:", sommen[0])
print("Aantal reeksen met een som van gegenereerde getallen tussen 50 en 70:", sommen[1])
print("Aantal reeksen met een som van gegenereerde getallen tussen 70 en 90:", sommen[2])
print("Aantal reeksen met een som van gegenereerde getallen van 90 of meer:", sommen[3])
