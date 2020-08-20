def omzetten_min(uren):
    return uren * 60

def omzetten_uren_en_min(min):
    uren = min // 60
    min %= 60
    return "{} uur {} min".format(int(uren), int(min))

counter = 0
som = 0
meer_dan_een_uur = 0
in_uur = int(input("Welk uur kwam de persoon binnen: "))
while in_uur != 0:
    counter += 1
    in_min = int(input("{}:".format(in_uur)))
    uit_uur = int(input("Welk uur kwam de persoon buiten: "))
    uit_min = int(input("{}:".format(uit_uur)))
    in_min += omzetten_min(in_uur)
    uit_min += omzetten_min(uit_uur)
    aanwezigheid = uit_min - in_min
    som += aanwezigheid
    if aanwezigheid > 60:
        meer_dan_een_uur += 1
    in_uur = int(input("Welk uur kwam de persoon binnen: "))
print("Gem:", omzetten_uren_en_min(som / counter))
print("Aantal bezoekers die langer bleven dan 1 uur:", meer_dan_een_uur)