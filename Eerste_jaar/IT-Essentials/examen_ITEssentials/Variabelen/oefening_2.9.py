aantal_centen = int(input("Geef aan hoeveel centen je hebt: "))

aantal_twee_euro = aantal_centen // 200
aantal_centen %= 200 #restwaarde
aantal_een_euro = aantal_centen // 100
aantal_centen %= 100 #restwaarde
aantal_vijftig_cent = aantal_centen // 50
aantal_centen %= 50 #restwaarde
aantal_twingtig_cent = aantal_centen // 20
aantal_centen %= 20 #restwaarde
aantal_tien_cent = aantal_centen // 10
aantal_centen %= 10 #restwaarde
aantal_vijf_cent = aantal_centen // 5
aantal_centen %= 5 #restwaarde
aantal_twee_cent = aantal_centen // 2
aantal_centen %= 2 #restwaarde

print("Aantal 2 euro's: {}".format(aantal_twee_euro))
print("Aantal 1 euro's: {}".format(aantal_een_euro))
print("Aantal 50 eurocenten: {}".format(aantal_vijf_cent))
print("Aantal 20 eurocenten: {}".format(aantal_twingtig_cent))
print("Aantal 10 eurocenten: {}".format(aantal_tien_cent))
print("Aantal 5 eurocenten: {}".format(aantal_vijf_cent))
print("Aantal 2 eurocenten: {}".format(aantal_twee_cent))
print("Aantal 1 eurocenten: {}".format(aantal_centen))
