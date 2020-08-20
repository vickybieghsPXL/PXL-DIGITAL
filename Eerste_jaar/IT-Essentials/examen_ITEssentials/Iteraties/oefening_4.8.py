def convert_hour_min_sec(seconds):
    hours = seconds // 3600
    seconds %= 3600
    minutes = seconds // 60
    seconds %= 60
    return "{:2}h {:2}m {:2}s".format(hours, minutes, seconds)

inschrijvingsnr = int(input("Geef de inschrijvingsnummer: "))
tijd = int(input("Geef de tijd in seconden: "))
snelst = tijd
snelst_nr = inschrijvingsnr

aantal_renners_hoger_dan_een_uur = 0
aantal = 1

if tijd >= 3600:
    aantal_renners_hoger_dan_een_uur += 1

inschrijvingsnr = int(input("Geef de inschrijvingsnummer: "))
while inschrijvingsnr >= 0:
    aantal += 1
    tijd = int(input("Geef de tijd in seconden: "))
    if tijd < snelst:
        snelst = tijd
        snelst_nr = inschrijvingsnr
    if tijd >= 3600:
        aantal_renners_hoger_dan_een_uur += 1
    inschrijvingsnr = int(input("Geef de inschrijvingsnummer: "))

print("Snelste renner met nummer {} had {} seconden".format(snelst_nr, snelst))
print(convert_hour_min_sec(snelst))
print("Percentage dat langer deed dan 1 uur: {}".format(aantal_renners_hoger_dan_een_uur / aantal * 100))
