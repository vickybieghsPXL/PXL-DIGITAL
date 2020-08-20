def print_tabel(neerslag_lijst, temperatuur_lijst):
    print("{:>5}\t{:>12}\t{:>8}".format("dag", "temperatuur", "neerslag"))
    for i in range(len(neerslag_lijst)):
        print("{:>5}\t{:>12}\t{:>8}".format(i + 1, temperatuur_lijst[i], neerslag_lijst[i]))


def is_tweedaage(neerslag_lijst, temperatuur_lijst):
    if len(neerslag_lijst) != 0 and min(temperatuur_lijst) >= 15 and "veel" not in neerslag_lijst:
        gemiddelde_temperatuur = sum(temperatuur_lijst) / len(temperatuur_lijst)
        if min(temperatuur_lijst) > (0.2 * gemiddelde_temperatuur):
            return True
    return False


neerslag_lijst = []
temperatuur_lijst = []

neerslag = input("Geef regen in\n")
dag = 0
while neerslag != "overvloed" and dag < 7:
    temperatuur = int(input("Geef temperatuur in\n"))

    neerslag_lijst.append(neerslag)
    temperatuur_lijst.append(temperatuur)

    if dag < 6:
        neerslag = input("Geef regen in\n")
    dag += 1

print_tabel(neerslag_lijst, temperatuur_lijst)

if 'overvloed' in neerslag_lijst:
    print("we blijven thuis")
elif is_tweedaage(neerslag_lijst, temperatuur_lijst):
    print("we gaan op tweedaagse")
else:
    print("we gaan op daguitstap")
