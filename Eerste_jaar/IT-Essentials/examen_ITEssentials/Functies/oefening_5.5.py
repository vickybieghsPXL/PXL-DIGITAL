def get_number(number, index): #Zoekt het cijfer in een integer, index begint van rechts Geeft 0 als de index niet bestaat
    return int((number / 10 ** index) % 10)


def if_gratis(lidnr):
    tweede_getal = get_number(lidnr, 5)
    vierde_getal = get_number(lidnr, 3)
    voorlaatste_getal = get_number(lidnr, 1)
    laatste_getal = get_number(lidnr, 0)
    if (tweede_getal * 10) + vierde_getal == (voorlaatste_getal * 10) + laatste_getal:
        return True
    return False

lidnr = int(input("Geef het lidnummer (7 cijfers): "))
if if_gratis(lidnr):
    print("Gratis")
else:
    print("Niet gratis!")
