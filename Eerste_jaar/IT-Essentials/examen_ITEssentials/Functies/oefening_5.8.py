def bereken_kostprijs(aantal_uren):
    print("Kostprijs: {} euro".format(aantal_uren * 12.5))

def bereken_aantal_personen(vierkante_meter):
    aantal_personen_full_time = vierkante_meter // (160 * 8)
    aantal_uren_part_time = round(((vierkante_meter % (160 * 8)) / 160), 2)
    print("{} aantal personen werken fulltime en een persoon werkt {} uur".format(aantal_personen_full_time, aantal_uren_part_time))
    aantal_uren_part_time = int(aantal_uren_part_time + 0.5)
    bereken_kostprijs(aantal_uren_part_time + (aantal_personen_full_time * 8))

vierkante_meter = int(input("Hoeveel vierkantemeter moet je schoonmaken: "))
while vierkante_meter != 0:
    bereken_aantal_personen(vierkante_meter)
    vierkante_meter = int(input("Hoeveel vierkantemeter moet je schoonmaken: "))
