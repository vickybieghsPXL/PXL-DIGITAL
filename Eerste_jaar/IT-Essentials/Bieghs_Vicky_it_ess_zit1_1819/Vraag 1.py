#Bieghs Vicky 1TINF


def vraag_input_A(voorraad_A):
    teller = 0
    for i in artikels_A:
        input_voorraad_A = int(input("hoeveel artikels zijn er in voorraad van het artikel " + i + " "))
        if input_voorraad_A <= j and teller < len(voorraad_A):
            if input_voorraad_A == 0:
                voorraad_A.remove(i)
            voorraad_A.remove(i)
            voorraad_A.insert(teller, input_voorraad_A)
            teller = teller + 1
    return voorraad_A


def vraag_input_S(bijbestellingen):
    teller = 0
    for i in artikels_S:
        input_voorraad_S = int(input("hoeveel artikels zijn er in voorraad van het artikel " + i + " "))
        teller = teller + 1
    for j in voorraad_S:
        if input_voorraad_S != j:
            bijbestellingen.append(j - input_voorraad_S)
    return bijbestellingen


artikels_S = ["S-kaftE34-5-100", "S-DVD345-1-124", "S-boekX33-3-256", "S-boekZ34-2-26"]
artikels_A = ["A-penD34-125", "A-bal34-145", "A-ballon34-15"]
voorraad_A = [125, 145, 15]
voorraad_S = [100, 124, 256, 26]
Bestelling_per =[5, 1, 3, 5]
nieuwe_voorraad_A = []
teller = 0
bijbestellingen = []

vraag_input_A(voorraad_A)
vraag_input_S(bijbestellingen)

print("lijst van bij te bestellen producten:", bijbestellingen, "\n", "lijst van de actie artikelen\n",  artikels_A)