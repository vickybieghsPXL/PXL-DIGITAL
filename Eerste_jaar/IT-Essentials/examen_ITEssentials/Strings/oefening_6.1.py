tekst = "hey this is me "
eerste_t = tekst.find("t")
eerste_grote_t = tekst.find("T")
if eerste_t == -1 and eerste_grote_t == -1:
    print("Geen t gevonden")
else:
    if eerste_grote_t < eerste_t and eerste_grote_t != -1:
        eerste_t = eerste_grote_t
    elif eerste_t == -1:
        eerste_t = eerste_grote_t
    print("Eerste t:", eerste_t)

if len(tekst) % 2 == 0:
    tekst = tekst.lower()
else:
    tekst = tekst.upper()
print(tekst)