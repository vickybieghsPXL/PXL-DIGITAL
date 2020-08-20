from random import randint

def zetOmNaarRomeinsCijfer(cijfer):
    roman = ["XL", "X", "IX", "V", "IV", "I"]
    waarde = [40, 10, 9, 5, 4, 1]
    aantal = []
    for i in range(len(roman)):
        aantal.append(cijfer // waarde[i])
        cijfer %= waarde[i]
    output = ""
    for i in range(len(roman)):
        output += roman[i] * aantal[i]
    return output


alfabet = "abcdefghijklmnopqrstuvwxyz"
letter = input("Geef een letter: ")
index = alfabet.find(letter) + 1
kleiner_dan_vijftig = 0
tussen_vijftig_zeventig = 0
tussen_zeventig_negentig = 0
hoger_dan_negentig = 0
for i in range(index):
    reeks = []
    print("Reeks {}".format(alfabet[i]))
    getal = randint(1, 49)
    vorig_getal = getal - 1
    while getal > vorig_getal:
        reeks.append(getal)
        print("Het romeins getal voor {} is {}".format(getal, zetOmNaarRomeinsCijfer(getal)))
        vorig_getal = getal
        getal = randint(1, 49)
    if sum(reeks) < 50:
        kleiner_dan_vijftig += 1
    elif sum(reeks) < 70:
        tussen_vijftig_zeventig += 1
    elif sum(reeks) < 90:
        tussen_zeventig_negentig += 1
    else:
        hoger_dan_negentig += 1
print()
print("Aantal reeksen met een som van gegeneerde getallen minder dan 50:", kleiner_dan_vijftig)
print("Aantal reeksen met een som van gegenereerde getallen tussen 50 en 70:", tussen_vijftig_zeventig)
print("Aantal reeksen met een som van gegenereerde getallen tussen 70 en 90:", tussen_zeventig_negentig)
print("Aantal reeksen met een som van gegenereerde getallen van 90 of meer:", hoger_dan_negentig)