def gemiddelde(list):
    som = 0
    for i in range(len(list)):
        som += list[i]
    return som / len(list)


teller = 0
temperatuur_list = []
neerslag_list = []

neerslag = input("Geef de neerslag (overvloed - veel - matig - geen): ")
while neerslag != "overvloed" and teller < 7:
    temperatuur = int(input("Wat is de temperatuur? "))
    temperatuur_list.append(temperatuur)
    neerslag_list.append(neerslag)
    if teller < 6:
        neerslag = input("Geef de neerslag (overvloed - veel - matig - geen): ")
    teller += 1
if len(temperatuur_list) != 0 and teller == 7:
    if min(temperatuur_list) >= 15 and min(temperatuur_list) > 0.2 * gemiddelde(
            temperatuur_list) and "veel" not in neerslag_list:
        conclusie = "We gaan op twee dagen uitstap"
    else:
        conclusie = "We gaan op 1 dag uitstap"
    print("{:>5} {:>20} {:>15}".format("dag", "temperatuur", "neerslag"))
else:
    conclusie = "We gaan niet op uitstap"
for i in range(len(temperatuur_list)):
    print("{:>5} {:>20} {:>15}".format(i + 1, temperatuur_list[i], neerslag_list[i]))
print(conclusie)
