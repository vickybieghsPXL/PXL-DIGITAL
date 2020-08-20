vertrek_uur = int(input(("Geef aan welk uur je gaat vertrekken (enkel het uur): ")))
vertrek_min = int(input(str(vertrek_uur) + ":"))
duur = int(input("Hoeveel min duurt de vlugt? "))
duur_uur = duur // 60
duur %= 60
aankomst_uur = vertrek_uur + duur_uur
aankomst_min = vertrek_min + duur
if aankomst_min >= 60:
    aankomst_uur += aankomst_min // 60
    aankomst_min %= 60
if aankomst_uur >= 24:
    aankomst_uur -= (aankomst_uur // 24) * 24
    aankomst_uur %= 24
aankomst_min = str(aankomst_min)
if len(aankomst_min) == 1:
    aankomst_min = "0" + aankomst_min
aankomst_uur = str(aankomst_uur)
if len(aankomst_uur) == 1:
    aankomst_uur = "0" + aankomst_uur
print("Aankomst: {:2}:{:2}".format(aankomst_uur, aankomst_min))