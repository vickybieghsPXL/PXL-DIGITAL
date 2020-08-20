aantal_afgelegde_km_per_jaar = int(input("Geef de afgelegde weg per jaar in km: "))
verbruik = float(input("Geef de verbuik in l/100km: "))
prijs_brandstof = float(input("Geef de prijs van 1l brandstof: "))

verbruik_per_jaar = (aantal_afgelegde_km_per_jaar / 100) * verbruik
totale_kosten_per_jaar = verbruik_per_jaar * prijs_brandstof
kostprijs_per_km = verbruik_per_jaar / aantal_afgelegde_km_per_jaar

print("Totale kosten per jaar: {}".format(verbruik_per_jaar))
print("Totale kostprijs per km: {}".format(kostprijs_per_km))